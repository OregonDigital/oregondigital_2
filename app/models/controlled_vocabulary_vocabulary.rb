class ControlledVocabularyVocabulary < ActiveRecord::Base
  belongs_to :controlled_vocabulary
  belongs_to :vocabulary
end
