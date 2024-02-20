# frozen_string_literal: true

require "rails_helper"

RSpec.describe "tickets/index", type: :view do
  it "displays a list of tickets" do
    tickets = FactoryBot.create_list(:ticket, 3)

    assign(:tickets, tickets)

    render

    expect(rendered).to have_selector("h1", text: "Ticket List")

    tickets.each do |ticket|
      expect(rendered).to have_selector("li", text: "Ticket ##{ticket.id}")
      expect(rendered).to have_link("Ticket ##{ticket.id}", href: ticket_path(ticket))
    end
  end
end
