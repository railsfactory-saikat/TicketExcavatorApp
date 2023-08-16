# frozen_string_literal: true

class Ticket < ApplicationRecord
  has_one :service_area
  has_one :excavator

  validates_presence_of :request_number, :sequence_number, :request_type, :well_known_text
end
