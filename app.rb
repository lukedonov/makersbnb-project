require 'sinatra/base'

class InnCognito < Sinatra::Base

  get '/' do

  end

  run! if app_file == $0
end