# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Ticket Details", type: :feature do
  let(:ticket) { create(:ticket, request_number: "123") }

  scenario "displays ticket details" do
    visit ticket_path(ticket)

    expect(page).to have_content("Ticket Details")
    expect(page).to have_content("Request Number: #{ticket.request_number}")
    expect(page).to have_content("Sequence Number: #{ticket.sequence_number}")
    expect(page).to have_content("Request Type: #{ticket.request_type}")
    expect(page).to have_content("Response Due DateTime: #{ticket.response_due_date_time}")
  end
end
