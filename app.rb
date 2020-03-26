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
    @current_user = User.find(id: session[:user_id])
    @properties = Property.all
    @properties = Property.sort_by_recent if params[:sort] == 'recent'
    @properties = Property.sort_by_cpn  if params[:sort] == 'price'
    erb :'properties/index'
  end

  get '/sign-up' do
    erb :'users/sign_up'
  end
  
  post '/sign-up' do
    @current_user = User.create(name: params[:name], email: params[:email], password: params[:password])
    session[:user_id] = @current_user.id unless @current_user.nil?
    redirect '/'
  end

  get '/sign-in' do
    erb :'users/sign_in'
  end

  post '/sign-in' do
    @current_user = User.authenticate(email: params[:email], password: params[:password])
    if @current_user
      session[:user_id] = @current_user.id
      redirect '/'
    else
      flash[:notice] = 'Please check your email or password.'
      redirect '/sign-in'
    end
  end


  get '/properties/new' do
    erb :'/properties/new'
  end

  post '/properties/new' do
    @current_user = User.find(id: session[:user_id])
    @property = Property.create(name: params[:name], description: params[:description], cpn: params[:cpn], user_id: @current_user.id)
    @availability = Availability.create(property_id: @property.id, start_date: params[:start_date], end_date: params[:end_date])
    redirect '/'
  end


  get '/properties/:id' do
    session[:place_id] = params[:id]
    @current_user = User.find(id: session[:user_id])
    @property = Property.find(id: session[:place_id])
    @availability = Availability.find(property_id: session[:place_id])
    erb :'/properties/booking'
  end

  post '/properties/requests' do
    @duration = params[:duration]
    @property = Property.find(id: session[:place_id])
    @booking = Booking.create(user_id: params[:user_id], property_id: params[:property_id], start_date: params[:start_date], end_date: params[:end_date], owner_id: params[:owner_id])
    erb :'properties/requests'  
  end

  
  get '/view-requests' do
    @current_user = User.find(id: session[:user_id])
    @properties = Property.where(user_id: @current_user.id)
    @bookings = Booking.find_by_owner_id(@current_user.id)
    @bookings.each_with_index do |b, i|
      @bookings.delete_at(i) if b.approval != Booking::PENDING
    end
    erb :'view-requests'
  end
  
  post '/request-accept' do
    @bookings = Booking.set_approval(params[:booking_id], Booking::APPROVED)
    redirect '/view-requests'
  end
  
  post '/sign-out' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect('/')
  end







  get '/upload' do
    erb :'upload/upload'
  end

  post '/upload' do
    @filename = params[:file][:filename]
    file = params[:file][:tempfile]

    File.open("./public/images/properties/#{@filename}", 'wb') do |f|
      f.write(file.read)
    end

    erb :'upload/show_upload'
  end
end
