require 'spec_helper'
require 'rack/test'
require_relative '../app'

describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }

  context 'GET /' do
    it 'shows a page with a form' do
      response = get('/')
      expect(response.status).to eq(200)
      expect(response.body).to include '<h1>Enter the name of a city:</h1>'
      expect(response.body).to include '<form action="/" method="post">'
      expect(response.body).to include '<input type="text" id="city" name="city" class="input-box"><br>'
      expect(response.body).to include '<input type="submit" value="Submit">'
    end
  end
  context 'POST /' do
    it 'shows a page with a weather info' do
      response = post('/?city=london')
      expect(response.status).to eq(200)
      expect(response.body).to include '<h1>Enter the name of a city:</h1>'
      expect(response.body).to include '<form action="/" method="post">'
      expect(response.body).to include '<input type="text" id="city" name="city" class="input-box"><br>'
      expect(response.body).to include '<input type="submit" value="Submit">'
      expect(response.body).to include 'Sunrise: '
      expect(response.body).to include 'Maximum Temperature: '
      expect(response.body).to include 'Feels Like: '
    end
    it "shows a page with a form and error message if city doesn't exist" do
      response = post('/?city=siuyadfkjghajwgfag')
      expect(response.status).to eq(200)
      expect(response.body).to include '<h1>Enter the name of a city:</h1>'
      expect(response.body).to include '<form action="/" method="post">'
      expect(response.body).to include '<input type="text" id="city" name="city" class="input-box"><br>'
      expect(response.body).to include '<input type="submit" value="Submit">'
      expect(response.body).to include '<h1 class="error-message">City not found!</h1>'
    end
  end
end
