require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Runners::Mp3DerivativeRunner do
  subject { OregonDigital::Derivatives::Runners::Mp3DerivativeRunner.new(path, callback_factory) }
  let(:callback_factory) { double("callback factory") }
  let(:derivative_callback) { instance_double(OregonDigital::Derivatives::DerivativeCallback) }
  let(:path) { Rails.root.join("tmp", "test_sound.mp3").to_s }

  describe "#run" do
    let(:asset) { object_double(Audio.new, :streamable_content => file) }
    let(:file) { instance_double(File) }
    let(:mp3_processor) { instance_double(OregonDigital::Derivatives::Processors::Mp3Processor) }
    before do
      allow(mp3_processor).to receive(:run)
      allow(derivative_callback).to receive(:success)
      allow(callback_factory).to receive(:new).with(asset).and_return(derivative_callback)
      allow(OregonDigital::Derivatives::Processors::Mp3Processor).to receive(:new).with(file, anything).and_return(mp3_processor)
      subject.run(asset)
    end
    it "should run mp3 generator" do
      expect(mp3_processor).to have_received(:run)
    end
    it "should call #mp3_success on the callback" do
      expect(derivative_callback).to have_received(:success).with(:mp3, path)
    end
  end
end
