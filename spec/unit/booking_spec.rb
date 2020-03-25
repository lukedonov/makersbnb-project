require './lib/database_connection'
require_relative '../database_helpers.rb'
require 'Property'
require 'user'
require 'booking'

describe Booking do
    
    describe ('.create') do
        
        it 'adds a new booking' do
            
            create_user_and_property
        
            booking = Booking.create(user_id: @user.id, property_id: @property.id, start_date: "2020-06-22 00:00:00", end_date: "2020-06-23 00:00:00", approval: false)

        end

    end

end