# frozen_string_literal: true

require "rails_helper"

RSpec.describe Address, type: :model do
  let(:ticket) { create(:ticket) }
  let(:excavator) { ticket.excavator }

  it { is_expected.to belong_to(:excavator) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:zip) }

  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        address = build(:address, excavator: excavator)
        expect(address).to be_valid
      end
    end

    context "with missing address" do
      it "is invalid" do
        address = build(:address, excavator: excavator, address: nil)
        expect(address).to be_invalid
        expect(address.errors[:address]).to include("can't be blank")
      end
    end

    context "with missing city" do
      it "is invalid" do
        address = build(:address, excavator: excavator, city: nil)
        expect(address).to be_invalid
        expect(address.errors[:city]).to include("can't be blank")
      end
    end

    context "with missing state" do
      it "is invalid" do
        address = build(:address, excavator: excavator, state: nil)
        expect(address).to be_invalid
        expect(address.errors[:state]).to include("can't be blank")
      end
    end

    context "with missing zip" do
      it "is invalid" do
        address = build(:address, excavator: excavator, zip: nil)
        expect(address).to be_invalid
        expect(address.errors[:zip]).to include("can't be blank")
      end
    end
  end
end
