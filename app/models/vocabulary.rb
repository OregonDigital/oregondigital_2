class Vocabulary < ActiveRecord::Base
  has_many :controlled_vocabulary_vocabularies
  has_many :controlled_vocabularies, :through => :controlled_vocabulary_vocabularies

  def validator
    BaseUriValidator.new(base_uri)
  end
end
