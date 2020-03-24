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

  get '/sign-in' do
    erb :'users/sign_in'
  end

  get '/sign-up' do
    erb :'users/sign_up'
  end

  post '/users/new' do
    @user = User.create(name: params[:name], email: params[:email], password: params[:password])
    session[:user_id] = @user.id unless @user.nil?
    redirect '/listings'
  end

  post '/users/sign-in' do
    @user = User.find_by_email(email: params[:email])
    session[:user_id] = @user.id unless @user.nil?
    redirect '/listings'
  end

  get '/listings' do
    @user = User.find(id: session[:user_id])
    @listings = Listing.all
    erb :listings
  end

  get '/listings/new' do
    erb :'/listings/new'
  end

  post '/listings/new' do
    @user = User.find(id: session[:user_id])
    Listing.create(name: params[:name], description: params[:description], cpn: params[:cpn], user_id: @user) 
    redirect '/listings'
  end

  get '/listings-sort' do
    if params[:sort] == "recent"
      @listings = Listing.sort_by_recent
    elsif params[:sort] == "price"
      @listings = Listing.sort_by_cpn
    end
    erb :listings
  end

  run! if app_file == $PROGRAM_NAME
end
