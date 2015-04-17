class CreateControlledVocabularyVocabularies < ActiveRecord::Migration
  def change
    create_table :controlled_vocabulary_vocabularies do |t|
      t.references :controlled_vocabulary
      t.references :vocabulary

      t.timestamps null: false
    end
  end
end
