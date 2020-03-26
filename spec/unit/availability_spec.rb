require './lib/database_connection'
require_relative '../helpers/database_helpers.rb'
require 'property'
require 'availability'

describe Availability do

  before(:each) do
    create_user_and_property
    @availability = described_class.create(property_id: @property.id, start_date: "2020-06-22", end_date: "2020-06-23")
  end

  describe ('.create') do
    it "creates a new instance of availability when a property listing is created" do  
      expect(@availability.property_id).to eq(@property.id)    
      expect(@availability.start_date).to eq("2020-06-22 00:00:00")    
      expect(@availability.end_date).to eq("2020-06-23 00:00:00") 
    end
  end

  # describe ('.edit') do
  #   it "allows a host to edit the availability dates of a property" do
  #     expect(@availability).to receive(:start_date).with("2020-07-05")
  #     expect(@availability.start_date).not_to eq "22 Jun 2020"
      
  #   end
  # end


  describe ('.find') do
    it "finds availibily based on property id" do
      
      result = Availability.find(property_id: @property.id)
      
      expect(result.first.property_id).to eq @property.id
      expect(result.first.start_date).to eq @availability.start_date
      expect(result.first.end_date).to eq @availability.end_date
    end
  end

end