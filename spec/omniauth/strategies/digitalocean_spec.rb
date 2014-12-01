require 'spec_helper'
require 'omniauth/strategies/digitalocean'

RSpec.describe OmniAuth::Strategies::DigitalOcean do
  let(:access_token) { double('Access Token') }
  subject(:strategy) { described_class.new({}) }

  before do
    allow(strategy).to receive(:access_token).and_return(access_token)
  end

  describe 'Options' do
    specify 'the strategy name' do
      expect(strategy.name).to eq('digitalocean')
    end

    specify 'the client options' do
      options = strategy.options.client_options

      expect(options[:site]).to eq('https://api.digitalocean.com')
      expect(options[:authorize_url]).to eq("https://cloud.digitalocean.com/v1/oauth/authorize")
      expect(options[:token_url]).to eq("https://cloud.digitalocean.com/v1/oauth/token")
    end
  end

  describe '#raw_info' do
    it 'returns the information about the user' do
      response = double('Account Response', parsed: { 'account' => 'bunk' })
      allow(access_token).to receive(:get).with('v2/account').and_return(response)

      expect(strategy.raw_info).to eq('bunk')
    end
  end

  describe '#uid' do
    it 'returns whatever is in the raw_info hash' do
      info = { 'uuid' => 'bunkbed' }
      allow(strategy).to receive(:raw_info).and_return(info)

      expect(strategy.uid).to eq(info['uuid'])
    end
  end

  describe '#info' do
    it 'includes the information returned from the account endpoint' do
      allow(strategy).to receive(:raw_info).and_return(
        'droplet_limit' => 25,
        'email' => 'web@digitalocean.com',
        'uuid' => 'b6fc48dbf6d9906cace5f3c78dc9851e757381ef',
        'email_verified' => true
      )
      expect(strategy.info[:droplet_limit]).to eq(25)
      expect(strategy.info[:email]).to eq("web@digitalocean.com")
      expect(strategy.info[:uuid]).to eq("b6fc48dbf6d9906cace5f3c78dc9851e757381ef")
      expect(strategy.info[:email_verified]).to eq(true)
    end
  end
end