require 'pg'
require './lib/database_connection'
require 'listing'

describe Listing do
    
    connection = DatabaseConnection.setup('inncognito_test')
    
    describe ('.all') do
        
        it('returns a list of listings') do
            connection.query("INSERT INTO users (id, name, email, password) VALUES ('1', 'bob', 'bob@bob.bob', 'bobbobbob');")
            p connection.query('SELECT * FROM users')
            connection.query("INSERT INTO properties (name, cpn, description, user_id) VALUES('test property', 122, 'test test test', '1');")
            listings = Listing.all
            expect(listings).to include('test property - 122. test test test')
        end
    end
    

end