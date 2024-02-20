# frozen_string_literal: true

require "rails_helper"

RSpec.describe Excavator, type: :model do
  let(:ticket) { create(:ticket) } # Assuming you have a Ticket factory

  it { is_expected.to belong_to(:ticket) }
  it { is_expected.to have_one(:address).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:company_name) }

  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        excavator = build(:excavator, ticket: ticket)
        expect(excavator).to be_valid
      end
    end

    context "with missing company_name" do
      it "is invalid" do
        excavator = build(:excavator, ticket: ticket, company_name: nil)
        expect(excavator).to be_invalid
        expect(excavator.errors[:company_name]).to include("can't be blank")
      end
    end
  end
end
