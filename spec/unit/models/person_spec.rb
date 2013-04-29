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

  describe "#display_location" do
    it "separates the first city from the first country by a comma" do
      person = FactoryGirl.build(:person, cities: ["Johannesburg"], countries: ["South Africa"])
      person.display_location.should == "Johannesburg, South Africa"
    end

    it "is nil if there are no countries" do
      FactoryGirl.build(:person, countries: []).display_location.should be_nil
    end
  end

  describe "#hired?" do
    it "is true when the status is Hired" do
      FactoryGirl.build(:person, step: "Hired").hired?.should be_true
    end

    it "is false when the status is not Hired" do
      FactoryGirl.build(:person, step: "Anything else").hired?.should be_false
    end
  end

  describe "#offered?" do
    it "is false if the status is not Offer, Declined Offer, or Hired" do
      FactoryGirl.build(:person, step: "Anything else").offered?.should be_false
    end

    it "is true if the status is Offer" do
      FactoryGirl.build(:person, step: "Offer").offered?.should be_true
    end

    it "is true if the status is Declined Offer" do
      FactoryGirl.build(:person, step: "Declined Offer").offered?.should be_true
    end
  end
end