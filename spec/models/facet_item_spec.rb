require 'rails_helper'

RSpec.describe FacetItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :value }
  end

end
