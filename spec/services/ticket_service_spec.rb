# frozen_string_literal: true

require "rails_helper"

RSpec.describe TicketService do
  let(:valid_json) { File.read("spec/test_data/valid_json_file.json") }

  describe "#ticket_params" do
    let(:valid_json_data) { '{"request_number": "123", "sequence_number": "456", "request_type": "Normal", "date_times": {"response_due_date_time": "2022-02-20T12:00:00Z"}, "excavation_info": {"digsite_info": {"well_known_text": "Some WKT"}}}' }

    it "returns the correct ticket params" do
      service = described_class.new(json_data: valid_json_data)
      params = service.ticket_params

      expect(params).to include(
        request_number: "123",
        sequence_number: "456",
        request_type: "Normal",
        response_due_date_time: "2022-02-20T12:00:00Z",
        well_known_text: "Some WKT",
        json_data: valid_json_data
      )
    end
  end

  describe "#valid_json?" do
    it "returns true for valid JSON" do
      service = described_class.new(json_data: valid_json)
      expect(service.valid_json?).to be true
    end

    it "returns false for invalid JSON" do
      service = described_class.new(json_data: "invalid_json")
      expect(service.valid_json?).to be false
    end
  end

  describe "#post_create_operation" do
    let(:ticket) { instance_double(Ticket) }

    it "calls the necessary methods to create associated records" do
      allow(ticket).to receive(:create_service_area)
      allow(ticket).to receive(:create_excavator)
      allow(ticket).to receive_message_chain(:excavator, :create_address).and_return(true)

      # Call the method that triggers the expectations
      service = described_class.new(ticket: ticket, json_data: valid_json)
      service.post_create_operation

      # Now, check if the methods have been called
      expect(ticket).to have_received(:create_service_area)
      expect(ticket).to have_received(:create_excavator)
      expect(ticket.excavator).to have_received(:create_address)
    end
  end
end
