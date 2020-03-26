require './lib/database_connection'
require_relative '../database_helpers.rb'
require 'Property'
require 'user'
require 'booking'

describe Booking do

    before(:each) do
        create_user_and_property
        @booking = described_class.create(user_id: @user.id, property_id: @property.id, start_date: "2020-06-22", end_date: "2020-06-23", owner_id: @property.user_id)
      end
    
    describe ('.create') do
        
        it 'adds a new booking' do
            expect(@booking.user_id).to eq(@user.id)    
            expect(@booking.property_id).to eq(@property.id)    
            expect(@booking.start_date).to eq("22 Jun 2020")    
            expect(@booking.end_date).to eq("23 Jun 2020")    
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