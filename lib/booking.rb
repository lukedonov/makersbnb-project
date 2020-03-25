class Booking

    attr_reader :id, :user_id, :property_id, :start_date, :end_date, :approval

    def initialize(id, user_id, property_id, start_date, end_date, approval) 
        @id = id
        @user_id = user_id
        @start_date = start_date
        @end_date = end_date
        @approval = approval
    end

    def self.create(user_id:, property_id:, start_date:, end_date:, approval:)
        
        result = DatabaseConnection.query("INSERT INTO bookings (user_id, property_id, start_date, end_date, approval) VALUES ('#{user_id}', '#{property_id}', '#{start_date}', '#{end_date}', #{approval}) RETURNING id, user_id, property_id, start_date, end_date, approval;")
        Booking.new(result[0]['id'], result[0]['user_id'], result[0]['property_id'], result[0]['start_date'], result[0]['end_date'], result[0]['approval'])

    end

end