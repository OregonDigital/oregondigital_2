require 'rails_helper'

RSpec.describe OregonDigital::Derivatives::Processors::Mp3Processor do
  subject { OregonDigital::Derivatives::Processors::Mp3Processor.new(file, options) }
  let(:file) { File.open(File.join(fixture_path, "fixture_sound.wav")) }
  let(:options) do
    {
      :path => path
    }
  end
  let(:path) { Rails.root.join("tmp", "test_sound.mp3").to_s }
  let(:pathname) { Pathname.new(path) }

  describe "#run" do
    before do
      subject.run
    end
    after do
      FileUtils.rm_rf(pathname.dirname) if File.exists?(path)
      FileUtils.mkdir(pathname.dirname)
    end
    it "should create an mp3 file" do
      expect(File.exists?(path)).to eq true
    end
  end
end
