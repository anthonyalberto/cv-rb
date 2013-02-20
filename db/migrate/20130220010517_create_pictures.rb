class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :owner_id, null: false
      t.string :picture, null: false
      t.string :legend

      t.timestamps
    end
  end
end
