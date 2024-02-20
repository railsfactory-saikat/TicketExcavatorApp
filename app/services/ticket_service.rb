# frozen_string_literal: true

class TicketService
  attr_accessor :json_data, :ticket

  def initialize(ticket: nil, json_data: nil)
    @ticket = ticket
    @json_data = json_data
  end

  def ticket_params
    {
      request_number: parsed_params[:request_number],
      sequence_number: parsed_params[:sequence_number],
      request_type: parsed_params[:request_type],
      response_due_date_time: parsed_params.dig(:date_times, :response_due_date_time),
      well_known_text: parsed_params.dig(:excavation_info, :digsite_info, :well_known_text),
      json_data: json_data
    }
  end

  def valid_json?
    parsed_json = JSON.parse(json_data)
    parsed_json.instance_of?(Hash)
  rescue JSON::ParserError
    false
  end

  def post_create_operation
    assign_service_area
    create_excavator
    assign_excavator_address
  end

  private

  def assign_service_area
    ticket.create_service_area(
      primary_sacode: parsed_params.dig(:service_area, :primary_service_area_code, :sa_code),
      additional_sacodes: parsed_params.dig(:service_area, :additional_service_area_codes, :sa_code)
    )
  end

  def create_excavator
    ticket.create_excavator(
      company_name: parsed_params.dig(:excavator, :company_name),
      crew_on_site: parsed_params.dig(:excavator, :crew_onsite)
    )
  end

  def assign_excavator_address
    return unless ticket.excavator

    excavator_params = parsed_params[:excavator]
    ticket.excavator.create_address(
      address: excavator_params[:address],
      city: excavator_params[:city],
      state: excavator_params[:state],
      zip: excavator_params[:zip]
    )
  end

  def parsed_params
    @json_data ||= ticket.json_data
    JSON.parse(json_data).deep_transform_keys(&:underscore).deep_symbolize_keys
  end
end
