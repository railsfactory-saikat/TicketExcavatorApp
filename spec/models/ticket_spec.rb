require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "is valid with valid attributes" do
    expect(build(:ticket)).to be_valid
  end

  it "is not valid without a RequestNumber" do
    ticket = build(:ticket, request_number: nil)
    expect(ticket).not_to be_valid
  end

  it "is associated with a service area and an excavator" do
    ticket = create(:ticket)
    expect(ticket.service_area).to be_valid
    expect(ticket.excavator).to be_valid
  end
end
