# frozen_string_literal: true

class Ticket < ApplicationRecord
  has_one :service_area, dependent: :destroy
  has_one :excavator, dependent: :destroy

  attr_accessor :json_data

  validates_presence_of :request_number, :sequence_number, :request_type, :well_known_text
  validates_uniqueness_of :request_number

  after_create :perform_post_create_operation

  private

  def perform_post_create_operation
    TicketService.new(ticket: self).post_create_operation
  end
end
