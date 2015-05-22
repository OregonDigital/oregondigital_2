require 'rails_helper'

RSpec.describe MarmottaConnection do
  subject { OregonDigital.marmotta }

  describe "#delete_all" do
    it "not error" do
      expect{subject.delete_all}.not_to raise_error
    end
  end
end
