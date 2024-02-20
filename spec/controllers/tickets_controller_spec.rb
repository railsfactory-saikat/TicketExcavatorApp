# frozen_string_literal: true

require "rails_helper"

RSpec.describe TicketsController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns all tickets to @tickets" do
      ticket1 = create(:ticket)
      ticket2 = create(:ticket, request_number: "09252012-00002")
      get :index
      expect(assigns(:tickets)).to contain_exactly(ticket1, ticket2)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      ticket = create(:ticket)
      get :show, params: { id: ticket.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested ticket to @ticket" do
      ticket = create(:ticket)
      get :show, params: { id: ticket.id }
      expect(assigns(:ticket)).to eq(ticket)
    end

    it "renders the show template" do
      ticket = create(:ticket)
      get :show, params: { id: ticket.id }
      expect(response).to render_template(:show)
    end
  end
end
