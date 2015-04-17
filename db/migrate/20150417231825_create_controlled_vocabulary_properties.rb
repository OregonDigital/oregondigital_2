class CreateControlledVocabularyProperties < ActiveRecord::Migration
  def change
    create_table :controlled_vocabulary_properties do |t|
      t.references :controlled_vocabulary, index: true
      t.string :property

      t.timestamps null: false
    end
  end
end
