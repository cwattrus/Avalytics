Avalytics::Application.routes.draw do
  devise_for :users, :skip => [:registrations]
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      put 'users' => 'devise/registrations#update', :as => 'user_registration'
    end

  resources :job_lists

  resources :people, :only => [:index, :show]

  match 'reports' => 'reports#index'
  match 'reports/sunburst' => 'reports#sunburst'
  match 'reports/bubbles' => 'reports#bubbles'
  match 'reports/genders' => 'reports#genders'
  match 'reports/races' => 'reports#races'
  match 'data/jobs_with_grades_with_steps_sunburst' => 'data#jobs_with_grades_with_steps_sunburst'
  match 'data/jobs_with_grades_with_steps_bubbles' => 'data#jobs_with_grades_with_steps_bubbles'
  match 'data/gender_pie' => 'data#gender_pie'
  match 'data/race_pie' => 'data#race_pie'
  match 'records_to_clean' => 'records_to_clean#index'
  match 'records_to_clean/strange_country_city_combos' => 'records_to_clean#strange_country_city_combos'
  match 'records_to_clean/gender' => 'records_to_clean#gender'
  match 'records_to_clean/fix_gender' => 'records_to_clean#fix_gender'
  match 'records_to_clean/race' => 'records_to_clean#race'
  match 'records_to_clean/fix_race' => 'records_to_clean#fix_race'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'people#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
