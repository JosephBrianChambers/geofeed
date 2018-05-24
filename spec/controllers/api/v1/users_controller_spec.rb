require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET #show" do
    subject { get :show, params: {} }

    describe "when user found" do
      let(:user) { create(:user, name: "John") }

      before { controller.stub(current_user: user, authorize_request: nil) }

      it "returns a success response" do
        subject

        expect(response).to be_success
      end

      it "returns correct response" do
        subject

        expect(JSON.parse(response.body)).to eq({ "name" => "John" })
      end
    end
  end
end
