# frozen_string_literal: true

require "rails_helper"

RSpec.describe ServiceArea, type: :model do
  let(:ticket) { create(:ticket) } # Assuming you have a Ticket factory

  it { is_expected.to belong_to(:ticket) }
  it { is_expected.to validate_presence_of(:primary_sacode) }

  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        service_area = build(:service_area, ticket: ticket)
        expect(service_area).to be_valid
      end
    end

    context "with missing primary_sacode" do
      it "is invalid" do
        service_area = build(:service_area, ticket: ticket, primary_sacode: nil)
        expect(service_area).to be_invalid
        expect(service_area.errors[:primary_sacode]).to include("can't be blank")
      end
    end
  end
end
