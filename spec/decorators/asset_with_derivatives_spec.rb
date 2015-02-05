require 'rails_helper'

RSpec.describe AssetWithDerivatives do
  subject { AssetWithDerivatives.new(asset, derivative_class, [runner]) }
  verify_contract :asset_with_derivatives
  let(:asset) { fake(:image) }
  let(:content) { fake(:FileContent) }
  let(:runner) { fake(:runner) { OregonDigital::Derivatives::Runners::DerivativeRunner } }
  let(:real_content) { "real" }
  let(:derivative_class) { fake() }
  let(:derivative_class_instance) { fake(:image_derivative_generator) { OregonDigital::Derivatives::Generators::ImageDerivativeGenerator } }
  before do
    stub(asset).content { content }
    stub(content).content { real_content }
    stub(derivative_class).new(subject, content, runner) { derivative_class_instance }
  end
  describe "#save" do
    context "when the content hasn't changed" do
      before do
        stub(content).content_changed? { false }
        subject.save
      end
      it "should not run the derivative generator" do
        expect(derivative_class_instance).not_to have_received.run
      end
    end
    context "when the content has changed" do
      before do
        stub(content).content_changed? { true }
        subject.save
      end
      it "should run the derivative generator" do
        expect(derivative_class_instance).to have_received.run
      end
      context "and the content is blank" do
        let(:real_content) { "" }
        it "should not run the derivative generator" do
          expect(derivative_class_instance).not_to have_received.run
        end
      end
    end
  end
end
