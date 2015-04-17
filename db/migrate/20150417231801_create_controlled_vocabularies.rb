class CreateControlledVocabularies < ActiveRecord::Migration
  def change
    create_table :controlled_vocabularies do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
