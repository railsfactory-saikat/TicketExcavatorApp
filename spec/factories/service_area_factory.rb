# frozen_string_literal: true

FactoryBot.define do
  factory :service_area do
    primary_sacode { "ZZGL103" }
    additional_sacodes { ["ZZL01", "ZZL02", "ZZL03"] }
  end
end
