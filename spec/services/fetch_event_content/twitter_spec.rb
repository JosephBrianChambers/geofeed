require 'rails_helper'

RSpec.describe FetchEventContent::Twitter do
  fixtures :content_providers

  subject { FetchEventContent::Twitter.new(event) }

  describe "#call" do
    let(:event) { create(:event) }

    describe "when tweet is returned" do
      describe "when tweet has geo" do
        describe "when no media present" do
          let(:raw_tweet) do
            path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
            JSON.parse(File.read(path))
          end

          before { expect_any_instance_of(Twitter::Client).to receive(:geo_fence_tweets).and_yield(raw_tweet) }

          let(:moment) { build(:moment) }

          it "persists moment" do
            expect { subject.call }.to change { Moment.count }.by(1)
          end

          it "persists author" do
            expect { subject.call }.to change { Author.count }.by(1)
          end

          it "adds moment to events moments" do
            expect { subject.call }.to change { event.moments.count }.by(1)
          end
        end

        describe "when no media present" do
          let(:raw_tweet) do
            path = Rails.root.join("spec", "fixtures", "raw_geo_tweet_photo.json")
            JSON.parse(File.read(path))
          end

          before { expect_any_instance_of(Twitter::Client).to receive(:geo_fence_tweets).and_yield(raw_tweet) }

          let(:moment) { build(:moment) }

          it "persists moment" do
            expect { subject.call }.to change { Moment.count }.by(1)
          end

          it "persists author" do
            expect { subject.call }.to change { Author.count }.by(1)
          end

          it "persists media" do
            expect { subject.call }.to change { Media.count }.by(1)
          end

          it "adds moment to events moments" do
            expect { subject.call }.to change { event.moments.count }.by(1)
          end
        end
      end
    end
  end
end
