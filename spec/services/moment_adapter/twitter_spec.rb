require 'rails_helper'

RSpec.describe MomentAdapter::Twitter do
  fixtures :content_providers

  subject { MomentAdapter::Twitter.new(raw_tweet) }

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

  describe "#author" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns author" do
      expect(subject.author.name).to eq("SF Weather, Warnings")
    end
  end

  describe "#medias" do
    describe "when geo tweet" do
      describe "when raw tweet does not have media" do
        let(:raw_tweet) do
          path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
          JSON.parse(File.read(path))
        end

        it "returns nil" do
          expect(subject.medias).to eq(nil)
        end
      end

      describe "when raw tweet has media" do
        let(:raw_tweet) do
          path = Rails.root.join("spec", "fixtures", "raw_geo_tweet_photo.json")
          JSON.parse(File.read(path))
        end

        it "returns medias" do
          expect(subject.medias.first.url).to eq("https://pbs.twimg.com/media/DjclOUQU0AEKb6k.jpg")
        end
      end
    end
  end

  describe "#content_provider" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns content_provider" do
      expect(subject.content_provider.name).to eq("Twitter")
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

  describe "#moment" do
    describe "when geo tweet" do
      let(:raw_tweet) do
        path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
        JSON.parse(File.read(path))
      end

      it "returns valid moment" do
        expect(subject.moment.valid?).to be(true)
      end
    end
  end
end

