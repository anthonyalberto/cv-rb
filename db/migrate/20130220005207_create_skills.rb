class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name, null: false
      t.integer :owner_id, null: false
      t.string :level, null: false

      t.timestamps
    end
    add_index :skills, :owner_id
  end
end
