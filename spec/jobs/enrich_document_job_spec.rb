require 'rails_helper'

RSpec.describe EnrichDocumentJob do
  subject { described_class }

  describe "perform" do
    it "should call Enricher" do
      enricher = instance_double(Enricher)
      id = "1"
      allow(Enricher).to receive(:new).with(id).and_return(enricher)
      allow(enricher).to receive(:enrich!)

      subject.perform_now(id)

      expect(enricher).to have_received(:enrich!)
    end
  end

end
