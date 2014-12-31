require 'rails_helper'

RSpec.describe GenericAsset do
  verify_contract(:generic_asset)

  let(:generic_asset) { GenericAsset.new(:id => id) }
  let(:id) {}
  it "should initialize" do
    expect{ GenericAsset.new }.not_to raise_error
  end

  describe "load from solr" do
    context "when it's loaded from solr" do
      let(:asset) { described_class.create(:title => ["bla"]) }
      subject {described_class.load_instance_from_solr(asset.id)}
      # Can't use Bogus here.
      before { Bogus.reset_overwritten_classes }
      it "should respond to all attributes" do
        expect(subject.title).to eq asset.title
      end
    end
  end

  describe 'id assignment' do
    context 'before the object is saved' do
      it 'should be nil' do
        expect(generic_asset.id).to be_nil
      end
    end
    context 'when a new object is saved' do
      before(:each) do
        fake_class(OregonDigital::IdService)
        stub(OregonDigital::IdService).mint { "9999" }
      end
      context "when it doesn't have an id" do
        before do
          generic_asset.save
        end
        it "should call the id service" do
          expect(OregonDigital::IdService).to have_received.mint
        end
        it 'should no longer be nil' do
          expect(generic_asset.id).not_to be_nil
        end
      end
      context 'but it already has an id' do
        let(:id) { "0000" }
        let(:generic_asset) { GenericAsset.new(:id => id) }
        it "should not call the id service" do
          expect(OregonDigital::IdService).not_to have_received.mint
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
end
