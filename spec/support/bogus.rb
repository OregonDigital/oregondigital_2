require 'bogus/rspec'
Bogus.configure do |c|
  c.fake_ar_attributes = true
  c.search_modules = [OregonDigital]
end
Bogus.fakes do
  fake(:injector, :class => proc{OregonDigital::Injector}) do
    thumbnail_path Rails.root.join("tmp", "1.jpg").to_s
  end
end
