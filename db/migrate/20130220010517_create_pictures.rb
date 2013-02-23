class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :owner_id, null: false
      t.integer :owner_type, null: false
      t.string :picture, null: false

      t.timestamps
    end
    add_index :pictures, :owner_id
    add_index :pictures, [:owner_id, :owner_type]
  end
end
