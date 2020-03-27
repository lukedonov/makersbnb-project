# frozen_string_literal: true

require_relative './database_connection'

class Property
  attr_reader :name, :description, :cpn, :user_id, :id
  def initialize(id, name, description, cpn, user_id)
    @id = id
    @name = name
    @description = description
    @cpn = cpn
    @user_id = user_id
  end

  def self.create(name:, description:, cpn:, user_id:)
    description = DatabaseConnection.prepare(description)
    result = DatabaseConnection.query("INSERT INTO properties (name, description, cpn, user_id) VALUES ('#{name}', '#{description}', #{cpn.to_i}, #{user_id}) RETURNING id, name, description, cpn, user_id;")
    map(result).first
  end

  def self.edit(id:, name:, description:, cpn:)
    description = DatabaseConnection.prepare(description)
    result = DatabaseConnection.query("UPDATE properties SET name = '#{name}', description = '#{description}', cpn = '#{cpn.to_i}' WHERE id = #{id} RETURNING id, name, description, cpn, user_id;")
    map(result).first
  end

  def self.all
    map(DatabaseConnection.query('SELECT * FROM properties'))
  end

  def self.sort_by_recent
    map(DatabaseConnection.query('SELECT * FROM properties ORDER BY id DESC'))
  end

  def self.sort_by_cpn
    map(DatabaseConnection.query('SELECT * FROM properties ORDER BY cpn ASC'))
  end

  def self.where(user_id:)
    map(DatabaseConnection.query("SELECT * FROM properties WHERE user_id = #{user_id};"))
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM properties WHERE id = #{id}")
    map(result).first
  end

  def self.map(sql_result)
   sql_result.map { |p| Property.new(p['id'], p['name'], p['description'], p['cpn'].to_i, p['user_id']) }
  end
end
