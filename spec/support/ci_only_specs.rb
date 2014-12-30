RSpec.configure do |c|
  c.filter_run_excluding :slow => true unless ENV["CI"]
end
