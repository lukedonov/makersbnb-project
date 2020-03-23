require 'sinatra/base'
require 'sinatra/flash'
require './lib/user'
require './lib/database_connection_setup'
require_relative './lib/listing'

class InnCognito < Sinatra::Base
  enable :sessions

  disable :strict_paths

  register Sinatra::Flash
  
  get '/' do
    "This is meant to be empty"
  end

  get '/sign-up' do
    erb :'users/sign_up' 
  end

  post '/users' do
    user = User.create(name: params[:name], email: params[:email], password: params[:password])
    
    redirect '/listings'
  end

  get '/listings' do
    @listings = Listing.all
    erb :listings
  end


  run! if app_file == $0
  
end