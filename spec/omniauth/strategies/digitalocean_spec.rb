require 'spec_helper'

describe OmniAuth::Strategies::Digitalocean do
  subject do
    described_class.new({})
  end

  context "client options" do
    it { expect(subject.options.name).to eq(:digitalocean) }

    it { expect(subject.options.client_options.site).to eq("https://cloud.digitalocean.com") }
    it { expect(subject.options.client_options.authorize_url).to eq("https://cloud.digitalocean.com/v1/oauth/authorize") }
    it { expect(subject.options.client_options.token_url).to eq("https://cloud.digitalocean.com/v1/oauth/token") }
  end

end