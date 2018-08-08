require 'rails_helper'

RSpec.describe "Events Api", type: :request do
  let(:current_user) { create(:user, name: "John") }

  before do
    allow_any_instance_of(AuthorizeApiRequest).to receive(:call).and_return({ user: current_user })
  end

  describe "GET /api/events/:id" do
    let(:event) do
      attrs = {
        start_time: Time.parse("2018-07-22 08:27:24 -0700"),
        end_time: Time.parse("2018-07-22 10:27:24 -0700"),
      }

      create(:event, :with_moments, attrs)
    end

    subject { get "/api/events/#{event.id}" }

    describe "when valid request" do
      it "returns successful response" do
        subject

        expect(response).to be_successful
      end

      it "returns correct payload" do
        subject

        expected_result = {
          "end_time" => "2018-07-22T17:27:24.000Z",
          "geo_fence" => {
            "type"=>"Polygon",
            "coordinates"=>[
              [
                [-122.43112564086914, 37.77885586164994],
                [-122.41086959838866, 37.77885586164994],
                [-122.41086959838866, 37.78848836594184],
                [-122.43112564086914, 37.78848836594184],
                [-122.43112564086914, 37.77885586164994]
              ]
            ]
          },
          "id" => event.id,
          "moments" => [
            {
              "id" => event.moments.first.id,
              "geojson_feature" => {
                "type" => "Feature",
                "geometry" => {
                  "type"=>"Point",
                  "coordinates"=>[-116.53397300000002, 31.77672500000001]
                },
                "properties" => {
                  "id" => event.moments.first.id
                }
              }
            }
          ],
          "start_time" => "2018-07-22T15:27:24.000Z",
        }

        expect(JSON.parse(response.body)).to eq(expected_result)
      end
    end
  end

  describe "POST /api/events" do
    subject { post "/api/events", params: params, as: :json }

    describe "when valid request" do
      let(:params) do
        end_time = Time.now

        {
          event: {
            start_time: end_time - 2.hours,
            end_time: end_time,
            geo_fence: geo_fence,
          }
        }
      end
      let(:geo_fence) { build(:geojson_polygon_feature, :sf_vanness) }

      it "returns successful response" do
        subject

        expect(response).to be_successful
      end

      it "creates new record" do
        expect {subject}.to change{Event.count}.by(1)
      end
    end
  end

  describe "GET /api/events/:id/fetch_content" do
    let(:event) { create(:event) }

    subject { get "/api/events/#{event.id}/fetch_content" }

    before { expect(FetchEventContent::Twitter).to receive(:call) }

    describe "when valid request" do
      it "returns successful response" do
        subject

        expect(response).to be_successful
      end
    end
  end
end
