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

- The scope needs to be separated by space and not comma: "public redeploy" instead of "public,redeploy" !

For additional information, refer to the [OmniAuth wiki](https://github.com/intridea/omniauth/wiki).

See the [example](https://github.com/digitaloceancloud/omniauth-digitalocean/blob/master/examples/sinatra/config.ru) Sinatra app for full examples

Note: before running example app, please add your application id and secret to ` example/config.ru ` file.

## License

omniauth-digitalocean is released under the MIT License.
