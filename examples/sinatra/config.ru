require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'omniauth-digitalocean'

class DigitalOceanExample < Sinatra::Base
  use Rack::Session::Cookie

  get '/' do
    <<~HTML
      <form method='post' action='/auth/digitalocean'>
        <input type="hidden" name="authenticity_token" value='#{request.env["rack.session"]["csrf"]}'>
        <button type='submit'>Login with DigitalOcean</button>
      </form>
    HTML
  end

  get '/auth/:provider/callback' do
    auth = request.env["omniauth.auth"]
    <<~HTML
      <b>User:</b> #{auth['info']['name']}<br/>
      <b>Team:</b> #{auth['info']['team_name']}<br/>
      <b>Full response:</b><br/>
      <pre>#{JSON.pretty_generate(auth)}</pre>
    HTML
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
