FactoryBot.define do
  factory :excavator do
    company_name { "John Doe CONSTRUCTION" }
    crew_on_site { true }
    association :address, strategy: :build
  end
end