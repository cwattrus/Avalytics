database_yaml = YAML::load(File.read("#{Rails.root}/config/mongo.yml"))
puts "Initializing mongodb"
if database_yaml[Rails.env] && database_yaml[Rails.env]['adapter'] == 'MongoDB'
  mongo_database = database_yaml[Rails.env]
  MongoMapper.connection = Mongo::Connection.new(mongo_database['host'], 27017, :pool_size => 5, :pool_timeout => 5)
  MongoMapper.database = "#myapp-#{Rails.env}"
end

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end