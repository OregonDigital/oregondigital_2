require 'rails_helper'

RSpec.describe GenericAsset do
  let(:generic_asset) { GenericAsset.new(:id => id) }
  let(:id) {}
  let(:file) { File.open(File.join(fixture_path, 'fixture_image.jpg'), 'rb') }
  it "should initialize" do
    expect{ GenericAsset.new }.not_to raise_error
  end

  describe "load from solr" do
    context "when it's loaded from solr" do
      let(:asset) { described_class.new(:title => ["bla"]) }
      subject {described_class.load_instance_from_solr(asset.id, asset.to_solr)}
      it "should respond to all attributes" do
        expect(subject.title).to eq asset.title
      end
    end
  end

  describe "#content" do
    context "when there's no content" do
      it "should return a blank content item" do
        expect(generic_asset.content).to be_kind_of FileContent
        expect(generic_asset.content.content).to be_blank
      end
    end
    context "when content is assigned" do
      before do
        generic_asset.add_file(file, :path => "content")
      end
      it "should work" do
        expect(generic_asset.content.content).not_to be_blank
      end
    end
  end

  describe "#workflow_metadata" do
    it "should be a yml file" do
      expect(subject.workflow_metadata).to be_kind_of(Files::YmlFile)
    end
  end

  describe 'id assignment' do
    context 'before the object is saved' do
      it 'should be nil' do
        expect(generic_asset.id).to be_nil
      end
    end
    context 'when a new object is saved' do
      let(:id_service) { instance_double("ActiveFedora::Noid::Service") }
      before(:each) do
        allow(OregonDigital.inject).to receive(:id_service).and_return(id_service)
        allow(id_service).to receive(:mint).and_return("987654321")
      end
      context "when it doesn't have an id" do
        before do
          generic_asset.save
        end
        it "should call the id service" do
          expect(id_service).to have_received(:mint)
        end
        it 'should no longer be nil' do
          expect(generic_asset.id).not_to be_nil
        end
        it 'should reverse the id for better bucketing' do
          expect(generic_asset.id).to eq('123456789')
        end
      end
      context 'but it already has an id' do
        let(:id) { "0000" }
        let(:generic_asset) { GenericAsset.new(:id => id) }
        it "should not call the id service" do
          expect(id_service).not_to have_received(:mint)
        end
        it 'should not override the pid' do
          expect(generic_asset.id).to eq id
        end
      end
    end
  end

  describe "permissions" do
    it "should use hydra access controls" do
      expect(described_class.ancestors).to include Hydra::AccessControls::Permissions
    end
  end

  describe "#title" do
    before do
      generic_asset.title << "Title"
    end
    it "should be gettable" do
      expect(generic_asset.title).to eq ["Title"]
    end
  end

  describe "#lcsubject" do
    context "when set to a string" do
      before do
        generic_asset.lcsubject = ["Test"]
      end
      it "should return as a string" do
        expect(generic_asset.lcsubject).to eq ["Test"]
      end
    end
    context "when set to a URI" do
      before do
        generic_asset.lcsubject = [RDF::URI("http://id.loc.gov/authorities/names/n80017721")]
      end
      it "should return as a TriplePoweredResource" do
        expect(generic_asset.lcsubject.first.class).to eq TriplePoweredResource
      end
    end
  end
end
