# frozen_string_literal: true

require_relative './database_connection'

class Listing
  attr_reader :name, :description, :cpn, :user_id, :id
  def initialize(id, name, description, cpn, user_id)
    @id = id
    @name = name
    @description = description
    @cpn = cpn
    @user_id = user_id
  end

  def self.create(name:, description:, cpn:, user_id:)
    result = DatabaseConnection.query("INSERT INTO properties (name, description, cpn, user_id) VALUES ('#{name}', '#{description}', #{cpn.to_i}, #{user_id}) RETURNING id, name, description, cpn, user_id;")
    Listing.new(result[0]['id'], result[0]['name'], result[0]['description'], result[0]['cpn'].to_i, result[0]['user_id'])
  end

  def self.all
    results = DatabaseConnection.query('SELECT * FROM properties')
  results.map { |p| Listing.new(p['id'], p['name'], p['description'], p['cpn'].to_i, p['user_id']) }
  end

  def self.sort_by_recent
    results = DatabaseConnection.query('SELECT * FROM properties ORDER BY id DESC')
    results.map { |p| Listing.new(p['name'], p['description'], p['cpn'].to_i, p['user_id']) }
  end

  def self.sort_by_cpn
    results = DatabaseConnection.query('SELECT * FROM properties ORDER BY cpn ASC')
    results.map { |p| Listing.new(p['name'], p['description'], p['cpn'].to_i, p['user_id']) }
  end

  def self.where(user_id:)
    result = DatabaseConnection.query("SELECT * FROM properties WHERE user_id = #{user_id};")
    result.map { |p| Listing.new(p['id'], p['name'], p['description'], p['cpn'].to_i, p['user_id']) }
  end 

end
