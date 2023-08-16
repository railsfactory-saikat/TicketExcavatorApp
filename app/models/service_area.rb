# frozen_string_literal: true

class ServiceArea < ApplicationRecord
  belongs_to :ticket

  validates_presence_of :primary_sacode
end
