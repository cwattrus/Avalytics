require "spec_helper"

describe Person do
  describe "#gender" do
    it "knows males" do
      FactoryGirl.build(:person, female: false).gender.should == "Male"
    end

    it "knows females" do
      FactoryGirl.build(:person, female: true).gender.should == "Female"
    end

    it "understands when we do not know the person's gender" do
      FactoryGirl.build(:person, female: nil).gender.should == "Unknown"
    end
  end
end