require 'spec_helper'

describe OmniAuth::Strategies::Digitalocean do
  subject do
    described_class.new({})
  end

  describe "production client options" do
    it { expect(subject.options.name).to eq(:digitalocean) }

    it { expect(subject.options.client_options.site).to eq("https://cloud.digitalocean.com") }
    it { expect(subject.options.client_options.authorize_url).to eq("https://cloud.digitalocean.com/v1/oauth/authorize") }
    it { expect(subject.options.client_options.token_url).to eq("https://cloud.digitalocean.com/v1/oauth/token") }
  end

  describe "callback phase instance methods" do
    let(:uuid) { 123 }
    let(:response_params) {
      {
        'info' => {
          'uuid' => uuid
        }
      }
    }
    let(:account_response) {
      { 'account' =>
        {
          'droplet_limit' => 25,
          'email' => 'foo@example.com',
          'uuid' => 'b6fc48dbf6d990634ce5f3c78dc9851e757381ef',
          'email_verified' => true
        }
      }
    }
    let(:account_json) { double(:json, parsed: account_response) }
    let(:access_token) { double('AccessToken', params: response_params, get: account_json) }

    before do
      allow(subject).to receive(:access_token).and_return(access_token)
    end

    describe "#uid" do
      it "returns uuid from the info hash" do
        expect(subject.uid).to eq(uuid)
      end
    end

    describe '#extra' do
      it 'includes the information returned from the account endpoint' do
        expect(subject.extra['droplet_limit']).to eq(25)
        expect(subject.extra['email']).to eq("foo@example.com")
        expect(subject.extra['uuid']).to eq("b6fc48dbf6d990634ce5f3c78dc9851e757381ef")
        expect(subject.extra['email_verified']).to eq(true)
      end
    end
  end
end
