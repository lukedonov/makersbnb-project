require 'sinatra/base'
require_relative './lib/database_connection_setup'
require_relative './lib/listing'

class InnCognito < Sinatra::Base

  get '/' do
    "Welcome"
  end

  get '/listings' do
    @listings = Listing.all
    erb :listings
  end


  run! if app_file == $0
end