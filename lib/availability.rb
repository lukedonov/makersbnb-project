class Availability

  attr_reader :id, :property_id, :start_date, :end_date
  
  def initialize(id, property_id, start_date, end_date) 
    @id = id
    @property_id = property_id
    @start_date = start_date
    @end_date = end_date
  end

  def self.create(property_id:, start_date:, end_date:)
    map(DatabaseConnection.query("INSERT INTO availability (property_id, start_date, end_date) VALUES ('#{property_id}', '#{start_date}', '#{end_date}') RETURNING id, property_id, start_date, end_date;")).first
  end

  def self.map(sql_result)
    sql_result.map { |b| Availability.new(b['id'], b['property_id'], b['start_date'], b['end_date']) }
end

end