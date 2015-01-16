require 'rails_helper'

RSpec.describe Image do
  verify_contract :image
  subject { Image.new }

  describe "contracts" do
    it "should be able to have an id" do
      expect(Image.new(:id => "1").id).to eq "1"
    end
  end

  [:thumbnail, :medium, :pyramidal].each do |derivative|
    describe "#has_#{derivative}" do
      before do
        eval "subject.has_#{derivative}=true"
      end
      it "should set it on workflow metadata" do
        expect(subject.workflow_metadata.send(:"has_#{derivative}")).to eq true
        expect(subject.send(:"has_#{derivative}")).to eq true
      end
    end
    describe "#{derivative}_path=" do
      let(:path) { Rails.root.join("tmp", "1.#{extension}").to_s }
      let(:extension) { derivative == :pyramidal ? "tiff" : "jpg" }
      before do
        eval "subject.#{derivative}_path=path"
      end
      it "should set it on workflow metadata" do
        expect(subject.workflow_metadata.send(:"#{derivative}_path")).to eq path
        expect(subject.send(:"#{derivative}_path")).to eq path
      end
    end
  end

  describe "derivatives" do
    fake(:image_derivative_generator) { OregonDigital::Derivatives::ImageDerivativeGenerator }
    let(:new_image_generator) { fake(:image_derivative_generator) { OregonDigital::Derivatives::ImageDerivativeGenerator } }
    fake(:injector)
    let(:thumbnail_path) { injector.thumbnail_path(subject.id) }
    let(:medium_path) { injector.medium_path(subject.id) }
    let(:pyramidal_path) { injector.pyramidal_path(subject.id) }
    before do
      stub(OregonDigital::Derivatives::ImageDerivativeGenerator).new(subject, subject.content, thumbnail_path, medium_path, pyramidal_path) { image_derivative_generator }
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
          stub(OregonDigital::Derivatives::ImageDerivativeGenerator).new(any_args) { new_image_generator }
          subject.save
        end
        it "should not try to run derivatives again" do
          expect(new_image_generator).not_to have_received.run
        end
      end
    end
  end
end
