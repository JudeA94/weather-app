require 'sinatra/base'
require 'sinatra/reloader'
require 'rest-client'
require 'json'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end


  get '/' do
    return erb(:index)
  end

  post '/' do
    city = params[:city]
    apiKey = '513491c5ff1a6cc04bb47081b6e1bad1'
    apiUrl = "http://api.openweathermap.org/data/2.5/weather?units=metric&q=#{city}&appid=#{apiKey}"
    data = RestClient.get(apiUrl)
    @weather_data = JSON.parse(data)
    return erb(:weather)
  end
end