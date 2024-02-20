# frozen_string_literal: true

module Api
  module V1
    class TicketsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :validate_json_data, only: [:create]

      def create
        ticket = Ticket.create(ticket_params)

        if ticket.id
          render json: { message: "Ticket created successfully" }, status: :created
        else
          render json: { error: ticket.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
      end

      private

      def ticket_params
        TicketService.new(json_data: request.body.read).ticket_params
      end

      def validate_json_data
        is_valid = TicketService.new(json_data: request.body.read).valid_json?
        return if is_valid

        render json: { error: "Invalid JSON format" }, status: :unprocessable_entity
      end
    end
  end
end
