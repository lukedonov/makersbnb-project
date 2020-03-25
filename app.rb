# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require './lib/user'
require './lib/database_connection_setup'
require_relative './lib/Property'

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
    redirect '/properties'
  end

  post '/users/sign-in' do
    @user = User.find_by_email(email: params[:email])
    session[:user_id] = @user.id unless @user.nil?
    redirect '/properties'
  end

  get '/properties' do
    @user = User.find(id: session[:user_id])
    @properties = Property.all
    erb :'properties/index'
  end

  get '/properties/new' do
    erb :'/properties/new'
  end

  post '/properties/new' do
    @user = User.find(id: session[:user_id])
    Property.create(name: params[:name], description: params[:description], cpn: params[:cpn], user_id: @user.id)
    redirect '/properties'
  end

  get '/properties-sort' do
    @user = User.find(id: session[:user_id])
    if params[:sort] == 'recent'
      @properties = Property.sort_by_recent
    elsif params[:sort] == 'price'
      @properties = Property.sort_by_cpn
    end
    erb :'properties/index'
  end

  get '/properties/booking' do
    @user = User.find(id: session[:user_id])
    erb :'/properties/booking'
  end

  post '/properties/booking' do
    @duration = params[:duration]    
    flash[:booking_requested] = "Your request to book new property for #{@duration} nights has been sent"
    redirect '/properties/booking'
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = "You have signed out."
    redirect('/properties')
  end

end
