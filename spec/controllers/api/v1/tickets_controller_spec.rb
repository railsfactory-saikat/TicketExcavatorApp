# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::TicketsController, type: :controller do
  describe "POST #create" do
    let(:valid_json) { File.read("spec/test_data/valid_json_file.json") }
    let(:invalid_json) { "invalid_json" }
    let(:blank_json) { "{}" }

    context "with valid JSON data" do
      it "creates a new ticket and associated records" do
        post :create, body: valid_json

        expect(response).to have_http_status(:created)
        expect(parsed_response(response)["message"]).to eq("Ticket created successfully")
      end
    end

    context "with invalid JSON data" do
      it "returns unprocessable entity status" do
        post :create, body: invalid_json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response(response)["error"]).to eq("Invalid JSON format")
      end
    end

    context "with duplicate request number" do
      it "returns unprocessable entity status" do
        post :create, body: valid_json
        post :create, body: valid_json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response(response)["error"]).to eq("Request number has already been taken")
      end
    end

    context "with modified JSON data" do
      it "creates a new ticket with modified data" do
        parsed_json = JSON.parse(valid_json)
        parsed_json["RequestNumber"] = "09252012-00001-modified"
        modified_json = parsed_json.to_json

        post :create, body: modified_json

        expect(response).to have_http_status(:created)
        expect(parsed_response(response)["message"]).to eq("Ticket created successfully")

        ticket = Ticket.last
        expect(ticket.request_number).to eq("09252012-00001-modified")
      end
    end

    context "with valid JSON data containing nil for required attributes" do
      it "returns unprocessable entity status" do
        post :create, body: blank_json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response(response)["error"]).to eq("Request number can't be blank, Sequence number can't be blank, Request type can't be blank, Well known text can't be blank")
      end
    end
  end
end

def parsed_response(response)
  JSON.parse(response.body)
end
