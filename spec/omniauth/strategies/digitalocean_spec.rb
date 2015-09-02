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
    let(:access_token) { double('AccessToken', params: response_params) }

    before do
      allow(subject).to receive(:access_token).and_return(access_token)
    end

    describe "#uid" do
      it "returns uuid from the info hash" do
        expect(subject.uid).to eq(uuid)
      end
    end
  end
end
