class Booking
    PENDING = :pending
    REJECTED = :rejected
    APPROVED = :approved

    attr_reader :id, :user_id, :property_id, :start_date, :end_date, :owner_id, :approval

    def initialize(id, user_id, property_id, start_date, end_date, owner_id, approval) 
        @id = id
        @user_id = user_id
        @property_id = property_id
        @start_date = start_date
        @end_date = end_date
        @owner_id = owner_id
        @approval = approval
    end

    def self.set_approval(booking_id, state)
        raise 'invalid approval state' unless state == PENDING || state == REJECTED || state == APPROVED
        map(DatabaseConnection.query("UPDATE bookings SET approval = '#{state}' WHERE id = #{booking_id} RETURNING id, user_id, property_id, start_date, end_date, approval;"))
        .first
    end

    def self.create(user_id:, property_id:, start_date:, end_date:, owner_id:)
        map(DatabaseConnection.query("INSERT INTO bookings (user_id, property_id, start_date, end_date, approval, owner_id) VALUES ('#{user_id}', '#{property_id}', '#{start_date}', '#{end_date}', '#{PENDING}', '#{owner_id}') RETURNING id, user_id, property_id, start_date, end_date, approval, owner_id;")).first
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

    def self.find_by_owner_id(id)
        map(DatabaseConnection.query("SELECT * FROM bookings WHERE owner_id = #{id}"))
    end

    private
    
    def self.map(sql_result)
        sql_result.map { |b| Booking.new(b['id'], b['user_id'], b['property_id'], b['start_date'], b['end_date'], b['owner_id'], b['approval'].to_sym) }
    end
end