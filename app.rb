# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require 'sass'
require './lib/user'
require './lib/availability'
require './lib/booking'
require './lib/database_connection_setup'
require './lib/property'

class InnCognito < Sinatra::Base
  register Sinatra::Reloader
  register Sinatra::Flash
  enable :sessions
  disable :strict_paths
  set :views, 'public/assets/views/'
  set :scss, 'public/assets/sass/'

  def location(*args)
    session[:location] = []
    args.each do |a|
      session[:location] << { name: a, link: request.path_info }
    end
  end

  get '/' do
    location 'home'
    @current_user = User.find(id: session[:user_id])
    @properties = Property.all
    @properties = Property.sort_by_recent if params[:sort] == 'recent'
    @properties = Property.sort_by_low_cpn if params[:sort] == 'lowprice'
    @properties = Property.sort_by_high_cpn if params[:sort] == 'highprice'
    erb :index
  end

  get '/sign-up' do
    location 'sign up'
    session[:location] = [{ name: 'sign up', link: request.path_info }]
    erb :'users/sign_up'
  end

  post '/sign-up' do
    @current_user = User.create(name: params[:name], email: params[:email], password: params[:password])
    session[:user_id] = @current_user.id unless @current_user.nil?
    redirect '/'
  end

  get '/sign-in' do
    location 'sign in'
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

  get '/book/:id' do
    location 'new booking'
    session[:place_id] = params[:id]
    @current_user = User.find(id: session[:user_id])
    @property = Property.find(id: session[:place_id])
    @availability = Availability.find(property_id: session[:place_id])
    erb :'account/create_booking_request'
  end

  post '/book/success' do
    @duration = (Date.parse(params[:end_date]) - Date.parse(params[:start_date])).to_i
    @property = Property.find(id: session[:place_id])

    begin
      @booking = Booking.create(user_id: params[:user_id], property_id: params[:property_id], start_date: params[:start_date], end_date: params[:end_date], owner_id: params[:owner_id])
    rescue StandardError => e
      @error = e
    end

    erb :'account/booking_request_confirmation'
  end

  get '/account/add-property' do
    location 'new property'
    erb :'account/add_property'
  end

  post '/account/add-property' do
    @current_user = User.find(id: session[:user_id])
    @property = Property.create(name: params[:name], description: params[:description], cpn: params[:cpn], user_id: @current_user.id)
    @availability = Availability.create(property_id: @property.id, start_date: params[:start_date], end_date: params[:end_date])
    path = "./public/images/properties/#{@property.id}"
    if params[:file]
      Dir.mkdir(path) unless Dir[path].any?
      @filename = params[:file][:filename]
      file = params[:file][:tempfile]
      File.open("#{path}/#{(Dir[path + '/*'].length + 1)}_#{@filename}", 'wb') do |f|
        f.write(file.read)
      end
    end
    redirect '/'
  end

  get '/account/manage-bookings' do
    location 'manage bookings'
    @current_user = User.find(id: session[:user_id])
    @properties = Property.where(user_id: @current_user.id)
    @bookings = Booking.find_by_owner_id(@current_user.id)
    @requests = Booking.find_by_user_id(@current_user.id)
    @bookings.each_with_index do |b, i|
      @bookings.delete_at(i) if b.approval != Booking::PENDING
    end
    erb :'account/manage_booking_requests'
  end

  get '/account/manage-bookings/:id' do
    session[:place_id] = params[:id]
    @current_user = User.find(id: session[:user_id])
    @property = Property.find(id: session[:place_id])
    @availability = Availability.find(property_id: session[:place_id])
    erb :'account/edit_property'
  end

  post '/account/manage-bookings/:id' do
    @property = Property.edit(id: session[:place_id], name: params[:name], description: params[:description], cpn: params[:cpn])
    @availability = Availability.edit(property_id: session[:place_id], start_date: params[:start_date], end_date: params[:end_date])
    redirect 'account/manage-bookings'
  end

  post '/account/approve-booking' do
    @bookings = Booking.set_approval(params[:booking_id], Booking::APPROVED)
    redirect '/account/manage-bookings'
  end

  post '/account/reject-booking' do
    @bookings = Booking.set_approval(params[:booking_id_2], Booking::REJECTED)
    redirect '/account/manage-bookings'
  end

  post '/sign-out' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect('/')
  end

  not_found do
    erb :'errors/404'
  end

  error do
    erb :'errors/500'
  end
end
