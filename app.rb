require 'sinatra/base'

class InnCognito < Sinatra::Base

  get '/' do

  end

  get '/listings' do
    "Welcome to Inn Cognito"
  end


  run! if app_file == $0
end