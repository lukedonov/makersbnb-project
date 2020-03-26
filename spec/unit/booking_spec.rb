require './lib/database_connection'
require_relative '../database_helpers.rb'
require 'Property'
require 'user'
require 'booking'
require 'availability'

describe Booking do

    context("property is available") do
        before(:each) do
            create_user_and_property
            Availability.create(property_id: @property.id, start_date: "2020-06-22 00:00:00", end_date: "2020-06-23 00:00:00")
            @booking = described_class.create(user_id: @user.id, property_id: @property.id, start_date: "2020-06-22 00:00:00", end_date: "2020-06-23 00:00:00")
        end
        
        describe ('.create') do
            
            it 'adds a new booking' do
                expect(@booking.user_id).to eq(@user.id)    
                expect(@booking.property_id).to eq(@property.id)    
                expect(@booking.start_date).to eq("2020-06-22 00:00:00")    
                expect(@booking.end_date).to eq("2020-06-23 00:00:00")    
                expect(@booking.approval).to eq(Booking::PENDING)    
            end
    
    
        end
    
        describe '.find_by_guest_id' do
            it 'gets correct bookings for guest' do
                expect(described_class.find_by_guest_id(@user.id).first.user_id).to eq(@user.id)
            end
        end
        
        describe '.find_by_property_id' do
            it 'gets correct property' do
                expect(described_class.find_by_property_id(@property.id).first.property_id).to eq(@property.id)
            end
        end
    
        describe '.set_approval' do
            it 'raises error given invalid state' do
                expect{described_class.set_approval(@booking.id, 'some invalid state')}.to raise_error 'invalid approval state'
            end
            it 'sets approval to :approved' do
                expect(described_class.set_approval(@booking.id, Booking::APPROVED).approval).to eq (Booking::APPROVED)
            end
            it 'sets approval to :rejected' do
                expect(described_class.set_approval(@booking.id, Booking::REJECTED).approval).to eq (Booking::REJECTED)
            end
        end
    end

    context("property is not available") do
        before(:each) do
            create_user_and_property
            Availability.create(property_id: @property.id, start_date: "2020-06-24 00:00:00", end_date: "2020-06-25 00:00:00")
            
        end
        
        describe ('.create') do
            it 'cannot add a new booking' do
                expect{described_class.create(user_id: @user.id, property_id: @property.id, start_date: "2020-06-22 00:00:00", end_date: "2020-06-23 00:00:00")}.to raise_error(RuntimeError, "the property is not available on these dates")
            end
        end

    end

    
end