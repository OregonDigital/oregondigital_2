require 'rails_helper'

RSpec.describe ImageWithDerivatives do
  subject { ImageWithDerivatives.new(image) }
  let(:image) { Image.new }
  describe "derivatives" do
    fake(:image_derivative_generator) { OregonDigital::Derivatives::Generators::ImageDerivativeGenerator }
    let(:new_image_generator) { fake(:image_derivative_generator) { OregonDigital::Derivatives::Generators::ImageDerivativeGenerator } }
    fake(:injector)
    let(:thumbnail_runner) { injector.thumbnail_runner(subject.id)}
    let(:medium_runner) { injector.medium_runner(subject.id) }
    let(:pyramidal_runner) { injector.pyramidal_runner(subject.id) }
    before do
      stub(OregonDigital::Derivatives::Generators::ImageDerivativeGenerator).new(subject, subject.content, thumbnail_runner, medium_runner, pyramidal_runner) { image_derivative_generator }
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
          stub(OregonDigital::Derivatives::Generators::ImageDerivativeGenerator).new(any_args) { new_image_generator }
          subject.save
        end
        it "should not try to run derivatives again" do
          expect(new_image_generator).not_to have_received.run
        end
      end
    end
  end
end
