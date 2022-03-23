# DigitalOcean's Omniauth strategy

This is the official Ruby OmniAuth strategy for authenticating to [DigitalOcean](https://www.digitalocean.com).

Before you can start developing your API client for DigitalOcean, you need to create an application on your account and copy the application id and secret.

## Installation

Add the strategy to your `Gemfile`:

```ruby
gem 'omniauth-digitalocean'
```

And bundle.

## Usage

You can integrate the strategy into your middleware in a `config.ru`:

```ruby
use OmniAuth::Builder do
  provider :digitalocean, SETTINGS['CLIENT_ID'], SETTINGS['CLIENT_SECRET'], scope: "read write"
end
```

If you're using Rails, you'll want to add to the middleware stack:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :digitalocean, SETTINGS['CLIENT_ID'], SETTINGS['CLIENT_SECRET'], scope: "read write"
end
```

- The scope needs to be separated by space and not comma: "read write" instead of "read,write" !

For additional information, refer to the [OmniAuth wiki](https://github.com/intridea/omniauth/wiki).

See the [example](https://github.com/digitaloceancloud/omniauth-digitalocean/blob/master/examples/sinatra/config.ru) Sinatra app for full examples

## Auth Hash Schema

The following information is provided in the auth hash accessible to the callback at `request.env["omniauth.auth"]`:

* `provider` - The OmniAuth provider, i.e. `digitalocean`
* `uid` - The UUID of the authenticating user
* `info` - A hash containing information about the user
  * `uuid` - The UUID of the authenticating user
  * `name` - The user's display name
  * `email` - The e-mail of the authenticating user
  * `team_uuid` - The UUID of the team when authenticated in a team context
  * `team_name` - The team's display name when authenticated in a team context
* `credentials` - A hash containing authentication information
  * `token` - The DigitalOcean OAuth access token
  * `refresh_token` - A refresh token that can be exchanged for a new OAuth access token
  * `expires` - Boolean indicating whether the access token has an expiry date
  * `expires_at` - Timestamp of the expiry time
* `extra` - Contains extra information returned from the `/v2/account` endpoint of the DigitalOcean API.
  * `droplet_limit` - The total number of Droplets current user or team may have active at one time
  * `floating_ip_limit`  - The total number of Floating IPs the current user or team may have
  * `email` - The email address for the current user
  * `uuid` - The UUID for the current user.
  * `email_verified` - If true, the user has verified their account via email
  * `status` - This value is one of `active`, `warning`, or `locked`
  * `status_message` - A human-readable message giving more details about the status of the account

## License

omniauth-digitalocean is released under the MIT License.
