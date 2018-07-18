require 'rails_helper'

RSpec.describe Twitter::ApiClient do
  subject { Twitter::ApiClient.new }

  describe "#search_tweets" do
    describe "with geo" do
      let(:options) do
        {
          lat: lat,
          lng: lng,
          radius_km: radius_km,
          q: q,
          max_id: max_id,
          count: 2
        }
      end
      let(:lat) { 37.783672270721034 }
      let(:lng) { -122.4209976196289 }
      let(:radius_km) { 0.5 }
      let(:q) { nil }
      let(:max_id) { nil }

      it "returns raw locations" do
        VCR.use_cassette('twitter_geo_search_tweets') do
          expect(subject.search_tweets(options)).to be_a(Hash)
        end
      end
    end
  end
end
