class Booking
    PENDING = :pending
    REJECTED = :rejected
    APPROVED = :approved

    attr_reader :id, :user_id, :property_id, :start_date, :end_date, :approval

    def initialize(id, user_id, property_id, start_date, end_date, approval) 
        @id = id
        @user_id = user_id
        @property_id = property_id
        @start_date = start_date
        @end_date = end_date
        @approval = approval
    end

    def self.set_approval(booking_id, state)
        raise 'invalid approval state' unless state == PENDING || state == REJECTED || state == APPROVED
        map(DatabaseConnection.query("UPDATE bookings SET approval = '#{state}' WHERE id = #{booking_id} RETURNING id, user_id, property_id, start_date, end_date, approval;"))
        .first
    end

    def self.create(user_id:, property_id:, start_date:, end_date:)
        raise 'the property is not available on these dates' unless check_availability(property_id: property_id, start_date: start_date, end_date: end_date) == true
        raise 'the property is already booked on these dates' unless check_booking_conflict(property_id: property_id, start_date: start_date, end_date: end_date) == true
        map(DatabaseConnection.query("INSERT INTO bookings (user_id, property_id, start_date, end_date, approval) VALUES ('#{user_id}', '#{property_id}', '#{start_date}', '#{end_date}', '#{PENDING}') RETURNING id, user_id, property_id, start_date, end_date, approval;")).first
    end

    def self.find_by_guest_id(id)
        map(DatabaseConnection.query("SELECT * FROM bookings WHERE user_id = #{id}"))
    end
    
    def self.find_by_property_id(id)
        map(DatabaseConnection.query("SELECT * FROM bookings WHERE property_id = #{id}"))
    end

    def self.find_by_approval_status(status)
        map(DatabaseConnection.query("SELECT * FROM bookings WHERE approval = #{status}"))
    end

    private
    
    def self.map(sql_result)
        sql_result.map { |b| Booking.new(b['id'], b['user_id'], b['property_id'], b['start_date'], b['end_date'], b['approval'].to_sym) }
    end

    def self.check_availability(property_id:, start_date:, end_date:)
        available = false
        results = Availability.find(property_id: property_id)
        
        results.each { |a|
            if start_date >= a.start_date && end_date <= a.end_date 
                available = true
            end
        }
        
        return available
    end

    def self.check_booking_conflict(property_id:, start_date:, end_date:)
        available = true
        results = find_by_property_id(property_id)

        results.each { |a|
            if start_date <= a.start_date && end_date >= a.start_date 
                available = false
            elsif start_date >= a.start_date && start_date <= a.end_date
                available = false
            end
        }

        return available

    end

    #------refactoring idea------
    # def any_overlapping_ranges(array_of_ranges)
    #  array_of_ranges.sort_by(&:first).each_cons(2).any?{|x,y|x.last>y.first}
    # end


end