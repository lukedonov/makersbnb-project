require_relative "./database_connection"

class Listing

    attr_reader :id, :name, :cpn, :description

    def initialize(id:, name:, cpn:, description:)
        @id = id
        @name = name
        @cpn = cpn
        @description = description
    end
    
    def self.all
        results = DatabaseConnection.query("SELECT * FROM properties")
        results.map { |property| 
        Listing.new(id: property['id'], name: property['name'], cpn: property['cpn'], description: property['description'])}
    end
end