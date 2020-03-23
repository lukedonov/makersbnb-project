# frozen_string_literal: true

require_relative './database_connection'

class Listing
  attr_reader :name, :description, :cpn
  def initialize(name, description, cpn)
    @name = name
    @description = description
    @cpn = cpn
  end

  def self.create(name:, description:, cpn:)
    result = DatabaseConnection.query("INSERT INTO properties (name, description, cpn) VALUES ('#{name}', '#{description}', #{cpn}) RETURNING id, name, description, cpn;")
    Listing.new(result[0]['name'], result[0]['description'], result[0]['cpn'].to_i)
  end

  def self.all
    results = DatabaseConnection.query('SELECT * FROM properties')
    results.map { |p| Listing.new(p['name'], p['description'], p['cpn'].to_i) }
  end
end
