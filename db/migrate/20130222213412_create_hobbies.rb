class CreateHobbies < ActiveRecord::Migration
  def change
    create_table :hobbies do |t|
      t.belongs_to :candidate, null: false
      t.string :name, null: false

      t.timestamps
    end
    add_index :hobbies, :candidate_id
  end
end
