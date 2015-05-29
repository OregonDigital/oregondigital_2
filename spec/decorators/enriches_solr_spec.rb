require 'rails_helper'

RSpec.describe EnrichesSolr do
  subject { described_class.new(image) }
  let(:image) { build_image(save: false) }

  describe "#save" do
    before do
      allow(EnrichDocumentJob).to receive(:perform_later).with(image.id)
    end
    context "when image fails to save" do
      it "should not call Enricher" do
        subject.save

        expect(EnrichDocumentJob).not_to have_received(:perform_later)
      end
    end
    context "when an image saves" do
      let(:image) { build_image(save: true) }
      it "should enrich the document" do
        result = subject.save

        expect(EnrichDocumentJob).to have_received(:perform_later).with(image.id)
        expect(result).to eq true
      end
    end
  end

  def build_image(save:)
    image = instance_double(Image)
    allow(image).to receive(:id).and_return("1")
    allow(image).to receive(:save).and_return(save)
    image
  end
end
