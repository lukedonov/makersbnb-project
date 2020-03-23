require 'sinatra/base'

class InnCognito < Sinatra::Base

  get '/' do

  end

  get '/sign-up' do
    erb :'users/sign_up' 
  end

  post '/users' do
    # stuff goes here
    
    redirect '/'
  end

  run! if app_file == $0
end