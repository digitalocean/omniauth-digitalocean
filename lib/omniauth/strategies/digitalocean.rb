require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    #
    # Authenticate to DigitalOcean via OAuth and retrieve basic user information.
    # Usage:
    #    use OmniAuth::Strategies::Digitalocean, 'consumerkey', 'consumersecret', :scope => 'read write', :display => 'plain'
    #
    class DigitalOcean < OmniAuth::Strategies::OAuth2
      AUTHENTICATION_PARAMETERS = %w(display state scope)

      # Name of this strategy
      option :name, 'digitalocean'

      # Client options ( see https://github.com/intridea/omniauth-oauth2 )
      option :client_options, {
        site: 'https://api.digitalocean.com',
        authorize_url: 'https://cloud.digitalocean.com/v1/oauth/authorize',
        token_url: 'https://cloud.digitalocean.com/v1/oauth/token',
      }

      option :authorize_options, AUTHENTICATION_PARAMETERS

      uid { raw_info['uuid'] }

      info do
        {
          droplet_limit: raw_info['droplet_limit'],
          email: raw_info['email'],
          uuid: raw_info['uuid'],
          email_verified: raw_info['email_verified'],
        }
      end

      ##
      # Retrieves the information about the user
      #
      def raw_info
        @raw_info ||= access_token.get('v2/account').parsed['account']
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

OmniAuth.config.add_camelization 'digitalocean', 'DigitalOcean'