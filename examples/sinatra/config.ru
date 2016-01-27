require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'omniauth-digitalocean'

class DigitalOceanExample < Sinatra::Base
  use Rack::Session::Cookie

  get '/' do
    redirect '/auth/digitalocean'
  end

  get '/auth/:provider/callback' do
    content_type 'text/plain'
    request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
  end

  get '/auth/failure' do
    content_type 'text/plain'
    request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
  end

  use OmniAuth::Builder do
    provider OmniAuth::Strategies::Digitalocean, ENV["DIGITALOCEAN_APP_ID"], ENV["DIGITALOCEAN_SECRET"], scope: "read write"
  end
end

run DigitalOceanExample.run!
