require './lib/database_connection'
require_relative '../database_helpers.rb'
require 'property'
require 'availability'

describe Availability do

  before(:each) do
    create_user_and_property
    @availability = described_class.create(property_id: @property.id, start_date: "2020-06-22 00:00:00", end_date: "2020-06-23 00:00:00")
  end

  describe ('.create') do
    it "creates a new instance of availability when a property listing is created" do  
      expect(@availability.property_id).to eq(@property.id)    
      expect(@availability.start_date).to eq("2020-06-22 00:00:00")    
      expect(@availability.end_date).to eq("2020-06-23 00:00:00") 
    end

  end
end