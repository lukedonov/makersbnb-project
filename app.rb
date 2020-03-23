require 'sinatra/base'

class InnCognito < Sinatra::Base

  get '/' do

  end

  get '/sign-up' do
    erb :'users/sign_up' 
  end

  run! if app_file == $0
end