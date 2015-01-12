require 'rails_helper'

RSpec.describe Image do
  verify_contract :image
  subject { Image.new }

  describe "contracts" do
    it "should be able to have an id" do
      expect(Image.new(:id => "1").id).to eq "1"
    end
  end

  describe "#has_thumbnail=" do
    before do
      subject.has_thumbnail = true
    end
    it "should set it on workflow metadata" do
      expect(subject.workflow_metadata.has_thumbnail).to eq true
      expect(subject.has_thumbnail).to eq true
    end
  end

  describe "#has_medium=" do
    before do
      subject.has_medium = true
    end
    it "should set it on workflow metadata" do
      expect(subject.workflow_metadata.has_medium).to eq true
      expect(subject.has_medium).to eq true
    end
  end

  describe "derivatives" do
    fake(:image_derivative_generator) { OregonDigital::Derivatives::ImageDerivativeGenerator }
    let(:new_image_generator) { fake(:image_derivative_generator) { OregonDigital::Derivatives::ImageDerivativeGenerator } }
    before do
      stub(OregonDigital::Derivatives::ImageDerivativeGenerator).new(subject, subject.content) { image_derivative_generator }
    end
    let(:assign_content) {}
    context "when saved" do
      let(:file) { File.open(File.join(fixture_path, 'fixture_image.jpg'), 'rb') }
      before do
        assign_content
        subject.save
      end
      context "when there's no new content" do
        it "should not try to save anything" do
          expect(image_derivative_generator).not_to have_received.run
        end
      end
      context "when there's new content" do
        let(:assign_content) do
          subject.content.content = file
        end
        it "should try to run derivatives" do
          expect(image_derivative_generator).to have_received.run
        end
      end
      context "when content is returned to nil" do
        let(:assign_content) do
          subject.content.content = file
          subject.save
          subject.reload
          subject.content.content = nil
          stub(OregonDigital::Derivatives::ImageDerivativeGenerator).new(subject, subject.content) { new_image_generator }
          subject.save
        end
        it "should not try to run derivatives again" do
          expect(new_image_generator).not_to have_received.run
        end
      end
    end
  end
end
