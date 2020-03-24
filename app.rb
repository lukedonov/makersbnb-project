# frozen_string_literal: true

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
    'This is meant to be empty'
  end

  get '/sign-up' do
    erb :'users/sign_up'
  end

  post '/users' do
    User.create(name: params[:name], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/listings'
  end

  get '/listings' do
    @user = User.find(id: session[:user_id])
    @listings = Listing.all
    erb :listings
  end

  get '/listings-sort' do
    
  end

  get '/listings/new' do
    erb :'/listings/new'
  end

  post '/listings/new' do
    @user =  1 #User.find(id: session[:user_id])     change when merge
    Listing.create(name: params[:name], description: params[:description], cpn: params[:cpn], user_id: @user) 
    redirect '/listings'
  end



  run! if app_file == $PROGRAM_NAME
end
