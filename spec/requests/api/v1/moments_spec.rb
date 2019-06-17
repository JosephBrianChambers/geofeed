require 'rails_helper'

RSpec.describe "Moments Api", type: :request do
  let(:current_user) { create(:user, name: "John") }

  before do
    allow_any_instance_of(AuthorizeApiRequest).to receive(:call).and_return({ user: current_user })
  end

  describe "GET /api/moments/:id" do
    let!(:moment) { create(:moment) }

    subject { get "/api/moments/#{moment.id}" }

    describe "when valid request" do
      it "returns successful response" do
        subject

        expect(response).to be_successful
      end

      it "returns correct payload" do
        subject

        expected_result = {
          "id" => moment.id,
          "caption" => "a longer description",
          "geojson_point" => {
            "type"=>"Point",
            "coordinates"=>[-116.53397300000002, 31.77672500000001]
          },
          "title" => "A Caption Title",
          "provider_id" => moment.provider_id,
          "author" => {
            "id"=> moment.author.id,
            "avatar_url" => "http://foo.net/bar",
            "name" => "Tom",
            "handle" => "tcool",
            "provider_id" => moment.author.provider_id
          },
          "medias" => [],
        }


        expect(JSON.parse(response.body)).to eq(expected_result)
      end
    end
  end
end
