# frozen_string_literal: true

class Api::V1::TicketsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @ticket_params = JSON.parse(request.body.read).deep_transform_keys(&:underscore).deep_symbolize_keys
    create_ticket
    assign_service_area
    create_excavator
    assign_excavator_address

    if @ticket.id
      render json: { message: "Ticket created successfully" }, status: :created
    else
      render json: { error: @ticket.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private

  def create_ticket
    well_known_text = @ticket_params.dig(:excavation_info, :digsite_info, :well_known_text)
    response_due_date_time = @ticket_params.dig(:date_times, :response_due_date_time)

    @ticket = Ticket.create(@ticket_params.slice(:request_number, :sequence_number, :request_type)
              .merge({ response_due_date_time: response_due_date_time,
                       well_known_text: well_known_text }))
  end

  def assign_service_area
    return unless @ticket.id

    additional_sacodes = @ticket_params.dig(:service_area, :additional_service_area_codes, :sa_code)
    primary_sacode = @ticket_params.dig(:service_area, :primary_service_area_code, :sa_code)
    @ticket.create_service_area(primary_sacode: primary_sacode, additional_sacodes: additional_sacodes)
  end

  def create_excavator
    return unless @ticket.id

    @excavator = @ticket.create_excavator(
      company_name: @ticket_params.dig(:excavator, :company_name),
      crew_on_site: @ticket_params.dig(:excavator, :crew_onsite)
    )
  end

  def assign_excavator_address
    return unless @excavator&.id

    excavator_params = @ticket_params[:excavator]
    @excavator.create_address(
      address: excavator_params[:address],
      city: excavator_params[:city],
      state: excavator_params[:state],
      zip: excavator_params[:zip]
    )
  end
end
