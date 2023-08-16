# frozen_string_literal: true

class Excavator < ApplicationRecord
  belongs_to :ticket
  has_one :address

  validates_presence_of :company_name
end
