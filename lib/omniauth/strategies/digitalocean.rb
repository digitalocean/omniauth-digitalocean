require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    #
    # Authenticate to DigitalOcean via OAuth and retrieve basic user information.
    # Usage:
    #    use OmniAuth::Strategies::Digitalocean, 'consumerkey', 'consumersecret', :scope => 'read write', :display => 'plain'
    #
    class Digitalocean < OmniAuth::Strategies::OAuth2
      AUTHENTICATION_PARAMETERS = %w(display state scope)
      BASE_URL = "https://cloud.digitalocean.com"

      option :name, :digitalocean

      unless OmniAuth.config.test_mode
        option :client_options, {
          :authorize_url => "#{BASE_URL}/v1/oauth/authorize",
          :token_url => "#{BASE_URL}/v1/oauth/token",
          :site => BASE_URL
        }
      else
        option :client_options, {
          :authorize_url => "http://localhost:3000/v1/oauth/authorize",
          :token_url => "http://localhost:3000/v1/oauth/token",
          :site => "http://localhost:3000"
        }
      end

      option :authorize_options, AUTHENTICATION_PARAMETERS

      uid do
        access_token.params['info']['uuid']
      end

      info do
        access_token.params['info']
      end

      # Hook useful for appending parameters into the auth url before sending
      # to provider.
      def request_phase
        super
      end

      # Hook used after response with code from provider. Used to prep token
      # request from provider.
      def callback_phase
        super
      end

      ##
      # You can pass +display+, +state+ or +scope+ params to the auth request, if
      # you need to set them dynamically. You can also set these options
      # in the OmniAuth config :authorize_params option.
      #
      # /v1/auth/digialocean?display=fancy&state=ABC
      #
      def authorize_params
        super.tap do |params|
          AUTHENTICATION_PARAMETERS.each do |v|
            params[v.to_sym] = request.params[v] if request.params[v]
          end
        end
      end

    end
  end
end
