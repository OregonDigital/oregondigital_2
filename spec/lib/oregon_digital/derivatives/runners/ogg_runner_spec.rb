require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::OggDerivativeRunner do
  subject { OregonDigital::Derivatives::Runners::OggDerivativeRunner.new(path, callback_factory) }
  let(:callback_factory) { double("callback factory") }
  let(:derivative_callback) { instance_double(OregonDigital::Derivatives::DerivativeCallback) }
  let(:path) { Rails.root.join("tmp", "test_sound.ogg").to_s }

  describe "#run" do
    let(:asset) { object_double(Audio.new, :streamable_content => file) }
    let(:file) { instance_double(File) }
    let(:ogg_processor) { instance_double(OregonDigital::Derivatives::Processors::OggProcessor) }
    before do
      allow(ogg_processor).to receive(:run)
      allow(derivative_callback).to receive(:success)
      allow(callback_factory).to receive(:new).with(asset).and_return(derivative_callback)
      allow(OregonDigital::Derivatives::Processors::OggProcessor).to receive(:new).with(file, anything).and_return(ogg_processor)
      subject.run(asset)
    end
    it "should run ogg generator" do
      expect(ogg_processor).to have_received(:run)
    end
    it "should call #ogg_success on the callback" do
      expect(derivative_callback).to have_received(:success).with(:ogg, path)
    end
  end
end
