require 'bogus/rspec'
Bogus.configure do |c|
  c.fake_ar_attributes = true
  c.search_modules = [OregonDigital]
end
Bogus.fakes do
  fake(:injector, :class => proc{OregonDigital::Injector}) do
    thumbnail_path Rails.root.join("media","thumbnails", "1", "0", "1.jpg").to_s
    medium_path Rails.root.join("media","medium-images", "1", "0", "1.jpg").to_s
    pyramidal_path Rails.root.join("media", "pyramidal", "1", "0", "1.tiff").to_s
    pdf_path Rails.root.join("media", "documents", "1", "0", "1").to_s
    thumbnail_runner Bogus.fake_for(:thumbnail_runner) { OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner }
    medium_runner Bogus.fake_for(:medium_runner) { OregonDigital::Derivatives::Runners::MediumImageDerivativeRunner }
    pyramidal_runner Bogus.fake_for(:pyramidal_runner) { OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner }
    pdf_runner Bogus.fake_for(:pdf_runner) { OregonDigital::Derivatives::Runners::PdfRunner }
  end
end
RSpec.configure do |c|
  c.before do
    stub(OregonDigital).inject { fake(:injector) }
  end
end

module BogusHelpers
  def make_equal_to_fakes(thing)
    thing.define_singleton_method(:==) do |*args|
      return true if args.first.kind_of?(Bogus::Fake)
      super(*args)
    end
  end
end
RSpec.configure do |c|
  c.include BogusHelpers
end
