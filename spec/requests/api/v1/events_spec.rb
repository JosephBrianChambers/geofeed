require 'rails_helper'

RSpec.describe "Events Api", type: :request do
  let(:current_user) { create(:user, name: "John") }

  before do
    allow_any_instance_of(AuthorizeApiRequest).to receive(:call).and_return({ user: current_user })
  end

  describe "GET /api/events/:id" do
    let(:event) { create(:event, :with_moments) }

    subject { get "/api/events/#{event.id}" }

    describe "when valid request" do
      it "returns successful response" do
        subject

        expect(response).to be_success
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
            geo_fence: {
              "id": "6956f9e0bbcb87e818083ae7c84afd77",
              "type": "Feature",
              "properties": {},
              "geometry": {
                "coordinates": [
                  [
                    [
                      -95.45205688475845,
                      40.991283600137706
                    ],
                    [
                      -96.15518188475858,
                      37.66097503187095
                    ],
                    [
                      -80.59854125975905,
                      37.66097503187095
                    ],
                    [
                      -95.45205688475845,
                      40.991283600137706
                    ]
                  ]
                ],
                "type": "Polygon"
              }
            }
          }
        }
      end

      it "returns successful response" do
        subject

        expect(response).to be_success
      end

      it "creates new record" do
        expect {subject}.to change{Event.count}.by(1)
      end
    end
  end

  describe "GET /api/events/:id/fetch_content" do
    let(:event) { create(:event) }

    subject { get "/api/events/#{event.id}/fetch_content" }

    describe "when valid request" do
      it "returns successful response" do
        subject

        expect(response).to be_success
      end
    end
  end
end
