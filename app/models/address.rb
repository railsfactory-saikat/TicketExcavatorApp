# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :excavator

  validates_presence_of :address, :city, :state, :zip
end
