class LDPathConfiguration < ActiveRecord::Base
  validates :name, :path, :presence => true
end
