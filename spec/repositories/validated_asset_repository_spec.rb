require 'rails_helper'

RSpec.describe ValidatedAssetRepository do
  subject { ValidatedAssetRepository.new(Image) }
  before do
    cv = ControlledVocabulary.create(:name => "Subjects")
    v1 = Vocabulary.create(:base_uri => "http://id.loc.gov/authorities/subjects")
    v2 = Vocabulary.create(:base_uri => "http://opaquenamespace.org/ns/subject")
    v3 = Vocabulary.create(:base_uri => "http://vocab.getty.edu/tgn")
    cv.vocabularies << [v1, v2, v3]
    cv.save
    ControlledVocabularyProperty.create(:controlled_vocabulary => cv, :property => "lcsubject")
  end

  describe "#new" do
    let(:image) { Image.new }
    before do
      allow(Image).to receive(:new).and_return(image)
      allow(image).to receive(:create_or_update).and_return(true)
    end
    let(:result) { subject.new }
    it "should validate it" do
      result.lcsubject = ["bla"]

      expect(result).not_to be_valid
    end
    it "should not be able to save it with a bad subject" do
      result.lcsubject = ["bla"]

      expect(result.save).to eq false
    end
    it "should be able to save it with a good subject" do
      result.lcsubject = [RDF::URI("http://id.loc.gov/authorities/subjects/1")]

      expect(result.save).to eq true
    end
    it "should validate from multiple sources" do
      result.lcsubject = [RDF::URI("http://opaquenamespace.org/ns/subject/banana")]

      expect(result).to be_valid
    end
  end

  describe "#decorate" do
    let(:image) { Image.new }
    let(:result) { subject.decorate(image) }
    it "should decorate the asset passed" do
      expect(result.class).to eq ComposedValidations::WithValidatedProperty
      expect(result.__getobj__).to eq image
    end
  end

  describe "#find" do
    context "when given an existing asset" do
      let(:image) do
        Image.new do |i|
          allow(i).to receive(:id).and_return("1")
          i.lcsubject = ["bla"]
        end
      end
      let(:result) { subject.find(image.id) }
      before do
        allow(Image).to receive(:find).with("1").and_return(image)
      end
      it "should validate it" do
        expect(result).not_to be_valid
      end
    end
  end
end
