require 'bogus/rspec'
Bogus.configure do |c|
  c.fake_ar_attributes = true
  c.search_modules = [OregonDigital]
end
Bogus.fakes do
end
