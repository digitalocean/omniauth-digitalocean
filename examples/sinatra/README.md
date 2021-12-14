# Sinatra Example

A simple example of how to use `omniauth-digitalocean` strategy with Sinatra.

## Setup

Create an OAuth application in the [DigitalOcean control panel](https://cloud.digitalocean.com/account/api/applications).
The callback URL should be `http://127.0.0.1:4567/auth/digitalocean/callback`.

Next, set the environment variables `DIGITALOCEAN_APP_ID`
and `DIGITALOCEAN_SECRET` with the values from the control panel. Then run the
app with:

    bundle install
    bundle exec ruby config.ru

Now visit `http://127.0.0.1:4567` in the browser to login via DigitalOcean.