require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'omniauth-digitalocean'

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

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :digitalocean, "2431aea9301744c9243e5777d31d6375cd4d8673f86569e125ad880b8f4f38b3", "a5e779f88e6f8053f400fb917aaa3cf89f23e2f72d85f3e375ebc02b93153787", scope: "read write"
end
