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
      FactoryGirl.build(:person, step: "Hired").should be_hired
    end

    it "is false when the status is not Hired" do
      FactoryGirl.build(:person, step: "Anything else").should_not be_hired
    end
  end

  describe "#offered?" do
    it "is false if the status is not Offer, Declined Offer, or Hired" do
      FactoryGirl.build(:person, step: "Anything else").should_not be_offered
    end

    it "is true if the status is Offer" do
      FactoryGirl.build(:person, step: "Offer").should be_offered
    end

    it "is true if the status is Declined Offer" do
      FactoryGirl.build(:person, step: "Declined Offer").should be_offered
    end
  end

  describe '#office_interviewed?' do
    it "is false if the status is not Office Interview or above, and doesnt have the appropriate forms filled out" do
      FactoryGirl.build(:person, step: "Anything else", attached_files_and_forms: "").should_not be_office_interviewed
    end

    it "is true if the status is Office Interview" do
      FactoryGirl.build(:person, step: "Office Interview", attached_files_and_forms: "").should be_office_interviewed
    end

    it "is true if the attached files and forms has Assessment Scores in it" do
      FactoryGirl.build(:person, step: "Anything else", attached_files_and_forms: "foo, Assessment Scores, bar").should be_office_interviewed
    end

    it "is true if the attached files and forms has Cultural Interview in it" do
      FactoryGirl.build(:person, step: "Anything else", attached_files_and_forms: "foo, Cultural Interview Notes 1, bar").should be_office_interviewed
    end

    it "is true if the attached files and forms has Paired Code Interview in it" do
      FactoryGirl.build(:person, step: "Anything else", attached_files_and_forms: "foo, Paired Code Interview Notes 1, bar").should be_office_interviewed
    end

    it "is true if the attached files and forms has Technical Interview in it" do
      FactoryGirl.build(:person, step: "Anything else", attached_files_and_forms: "foo, Technical Interview Notes 1, bar").should be_office_interviewed
    end

    it "is true if the attached files and forms has Management Interview in it" do
      FactoryGirl.build(:person, step: "Anything else", attached_files_and_forms: "foo, Management Interview, bar").should be_office_interviewed
    end
  end
end