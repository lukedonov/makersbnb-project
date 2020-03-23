require 'sinatra/base'
require 'sinatra/flash'
require './lib/user'
require './lib/database_connection_setup'

class InnCognito < Sinatra::Base
  enable :sessions

  disable :strict_paths

  register Sinatra::Flash
  
  get '/' do

  end

  get '/sign-up' do
    erb :'users/sign_up' 
  end

  post '/users' do
    user = User.create(name: params[:name], email: params[:email], password: params[:password])
    
    redirect '/'
  end

  run! if app_file == $0
  
end