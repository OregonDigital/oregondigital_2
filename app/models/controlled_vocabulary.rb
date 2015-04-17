class ControlledVocabulary < ActiveRecord::Base
  has_many :vocabularies, :through => :controlled_vocabulary_vocabularies
  has_many :controlled_vocabulary_vocabularies

  def validator
    ComposedValidations::OrValidator.new(vocabularies.map(&:validator))
  end
end
