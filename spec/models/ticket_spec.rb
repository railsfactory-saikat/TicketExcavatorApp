# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ticket, type: :model do
  let(:valid_json) { '{"request_number": "123", "sequence_number": "456", "request_type": "Normal", "well_known_text": "Some WKT"}' }

  it { is_expected.to have_one(:service_area).dependent(:destroy) }
  it { is_expected.to have_one(:excavator).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:request_number) }
  it { is_expected.to validate_presence_of(:sequence_number) }
  it { is_expected.to validate_presence_of(:request_type) }
  it { is_expected.to validate_presence_of(:well_known_text) }
  it { is_expected.to validate_uniqueness_of(:request_number) }
end
