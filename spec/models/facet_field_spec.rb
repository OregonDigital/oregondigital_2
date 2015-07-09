require 'rails_helper'

RSpec.describe FacetField, type: :model do
  describe "validations" do
    it { should validate_presence_of :key }
  end
end
