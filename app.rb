require 'sinatra/base'
require 'sinatra/reloader'
require 'rest-client'
require 'json'
require 'time'

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
    api_key = '513491c5ff1a6cc04bb47081b6e1bad1'
    api_url = "http://api.openweathermap.org/data/2.5/weather?units=metric&q=#{city}&appid=#{api_key}"
    data = RestClient.get(api_url)
    weather_data = JSON.parse(data)
    @icon_code = weather_data['weather'][0]['icon']
    @location = "#{weather_data['name']}, #{weather_data['sys']['country']}"
    @description = weather_data['weather'][0]['description'].capitalize
    @current_temp = "#{weather_data['main']['temp'].round}\u00B0C"
    @feels_like = "#{weather_data['main']['feels_like'].round}\u00B0C"
    @min_temp = "#{weather_data['main']['temp_min'].round}\u00B0C"
    @max_temp = "#{weather_data['main']['temp_max'].round}\u00B0C"
    @humidity = "#{weather_data['main']['humidity']}%"
    @cloud_coverage = "#{weather_data['clouds']['all']}%"
    sunrise = weather_data['sys']['sunrise'].to_s
    @sunrise = DateTime.strptime(sunrise, '%s').strftime('%H:%M')
    sunset = weather_data['sys']['sunset'].to_s
    @sunset = DateTime.strptime(sunset, '%s').strftime('%H:%M')
    return erb(:weather)
  end
end
