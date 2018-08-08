require 'rails_helper'

RSpec.describe MomentParserAdapter::Tweet::MomentAttributes do
  fixtures :content_providers

  subject { MomentParserAdapter::Tweet::MomentAttributes.new(raw_tweet) }

  describe "#lng_lat" do
    describe "when geo tweet" do
      let(:raw_tweet) do
        path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
        JSON.parse(File.read(path))
      end

      it "returns coordintates" do
        expect(subject.lng_lat).to eq([-122.42, 37.78])
      end
    end
  end

  describe "#caption" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns caption" do
      expected_result = "temperature down 80°F -&gt; 77°F\nhumidity up 56% -&gt; 68%\nwind 18mph -&gt; 22mph"
      expect(subject.caption).to eq(expected_result)
    end
  end

  describe "#title" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns nil" do
      expect(subject.title).to eq(nil)
    end
  end

  describe "#content_provider_id" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns content_provider" do
      expect(ContentProvider.find(subject.content_provider_id).name).to eq("Twitter")
    end
  end

  describe "#provider_id" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns provider id" do
      expect(subject.provider_id).to eq("1019745331855020033")
    end
  end

  describe "#moment_attributes" do
    describe "when geo tweet" do
      let(:raw_tweet) do
        path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
        JSON.parse(File.read(path))
      end

      it "returns moment attributes" do
        expected_result = {
          :content_provider_id => 376077238,
          :lng_lat => [-122.42, 37.78],
          :caption => "temperature down 80°F -&gt; 77°F\nhumidity up 56% -&gt; 68%\nwind 18mph -&gt; 22mph",
          :provider_id => "1019745331855020033"
        }

        expect(subject.moment_attributes).to eq(expected_result)
      end
    end
  end
end

