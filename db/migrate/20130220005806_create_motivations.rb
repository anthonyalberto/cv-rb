class CreateMotivations < ActiveRecord::Migration
  def change
    create_table :motivations do |t|
      t.belongs_to :candidate, null: false
      t.string :name, null: false

      t.timestamps
    end
    add_index :motivations, :candidate_id
  end
end
