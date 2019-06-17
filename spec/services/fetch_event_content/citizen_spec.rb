require 'rails_helper'

RSpec.describe FetchEventContent::Citizen do
  fixtures :content_providers

  subject { FetchEventContent::Citizen.new(event) }

  describe "#call" do
    let(:event) { create(:event) }

    describe "when alerts are returned" do
      before { expect_any_instance_of(Citizen::Client).to receive(:geo_fence_alerts).and_yield(raw_alert) }

      describe "when alert has geo" do
        let(:raw_alert) do
          path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
          JSON.parse(File.read(path))
        end

        it "persists moment" do
          expect { subject.call }.to change { Moment.count }.by(1)
        end

        it "persists author" do
          expect { subject.call }.to change { Author.count }.by(1)
        end

        it "persists media" do
          expect { subject.call }.to change { Media.count }.by(0)
        end

        it "adds moment to events moments" do
          expect { subject.call }.to change { event.moments.count }.by(1)
        end
      end
    end
  end
end
