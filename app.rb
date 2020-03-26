# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './lib/user'
require './lib/availability'
require './lib/booking'
require './lib/database_connection_setup'
require_relative './lib/Property'

class InnCognito < Sinatra::Base
  enable :sessions
  disable :strict_paths
  register Sinatra::Reloader
  register Sinatra::Flash

  get '/' do
    redirect '/properties'
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
    @property = Property.create(name: params[:name], description: params[:description], cpn: params[:cpn], user_id: @user.id)
    @availability = Availability.create(property_id: @property.id, start_date: params[:start_date], end_date: params[:end_date])
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

  get '/properties/:id' do
    session[:place_id] = params[:id]
    @user = User.find(id: session[:user_id])
    @property = Property.find(id: session[:place_id])
    erb :'/properties/booking'
  end

  post '/properties/requests' do
    @duration = params[:duration]
    @property = Property.find(id: session[:place_id])
    @booking = Booking.create(user_id: params[:user_id], property_id: params[:property_id], start_date: params[:start_date], end_date: params[:end_date])
    erb :'properties/requests'
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect('/properties')
  end

  get '/view-requests' do
    @user = User.find(id: session[:user_id])
    @properties = Property.all
    @booking = Booking.find_by_approval_status('approval')
    erb :'view-requests'
  end
end
