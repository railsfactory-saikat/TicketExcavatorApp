# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    address { "555 Some RD" }
    city { "SOME PARK" }
    state { "ZZ" }
    zip { "55555" }
  end
end
