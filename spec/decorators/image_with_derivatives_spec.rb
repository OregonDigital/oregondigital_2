require 'rails_helper'

RSpec.describe ImageWithDerivatives do
  verify_contract :image_with_derivatives
  subject { ImageWithDerivatives.new(image) }
  fake(:image, :id => "1")
  fake(:asset_with_derivatives)
  fake(:injector)
  let(:thumbnail_runner) { injector.thumbnail_runner(subject.id)}
  let(:medium_runner) { injector.medium_runner(subject.id) }
  let(:pyramidal_runner) { injector.pyramidal_runner(subject.id) }
  fake(:runner_list) { OregonDigital::Derivatives::Runners::RunnerList }
  before do
    stub(image).injector { injector }
  end
  describe "derivatives" do
    context "when saved" do
      before do
        stub(OregonDigital::Derivatives::Runners::RunnerList).new([thumbnail_runner,medium_runner, pyramidal_runner]) { runner_list }
        stub(AssetWithDerivatives).new(image, runner_list) { asset_with_derivatives }
        subject.save
      end
      it "should call asset_with_derivative's save method" do
        expect(asset_with_derivatives).to have_received.save
      end
    end
  end

  let(:path) { Rails.root.join("tmp", "1.jpg").to_s }

  describe "#thumbnail_success" do
    let(:result) { subject.thumbnail_success(path) }
    before do
      result
    end
    it "should set has_thumbnail" do
      expect(image).to have_received(:has_thumbnail=, true)
    end
    it "should set thumbnail_path" do
      expect(image).to have_received(:thumbnail_path=, path)
    end
  end

  describe "#pyramidal_success" do
    let(:path) { Rails.root.join("tmp", "1.tiff").to_s }
    let(:result) { subject.pyramidal_success(path) }
    before do
      result
    end
    it "should set has_pyramidal" do
      expect(image).to have_received(:has_pyramidal=, true)
    end
    it "should set pyramidal_path" do
      expect(image).to have_received(:pyramidal_path=, path)
    end
  end

  describe "#medium_success" do
    let(:result) { subject.medium_success(path) }
    before do
      result
    end
    it "should set has_medium" do
      expect(image).to have_received(:has_medium=, true)
    end
    it "should set medium_path" do
      expect(image).to have_received(:medium_path=, path)
    end
  end
end
