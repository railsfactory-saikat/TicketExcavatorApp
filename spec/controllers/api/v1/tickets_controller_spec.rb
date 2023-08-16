require 'rails_helper'

RSpec.describe Api::V1::TicketsController, type: :controller do
  describe "POST #create" do
    it "creates a new ticket" do
      ticket_params = {
        RequestNumber: "123",
        SequenceNumber: "456",
        RequestType: "Normal",
        DateTimes: { "ResponseDueDateTime" => "2011-07-13T23:59:59Z" },
        ServiceArea: {
          PrimaryServiceAreaCode: { "SACode" => "ZZGL103" },
          AdditionalServiceAreaCodes: { "SACode" => ["ZZL01", "ZZL02", "ZZL03"] }
        },
        Excavator: {
          CompanyName: "John Doe CONSTRUCTION",
          CrewOnSite: true,
          Address: {
            AddressNum: ["555 Some RD"],
            City: "SOME PARK",
            State: "ZZ",
            Zip: "55555"
          }
        },
        ExcavationInfo: {
          DigsiteInfo: { "WellKnownText" => "POLYGON((...))" }
        }
      }

      post :create, body: ticket_params.to_json

      expect(response).to have_http_status(:created)
      expect(Ticket.count).to eq(1)
    end

    it "returns an error for invalid attributes" do
      post :create, body: {}.to_json

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
