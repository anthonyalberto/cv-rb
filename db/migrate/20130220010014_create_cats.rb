class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.belongs_to :candidate, null: false
      t.string :name, null: false
      t.string :current_status

      t.timestamps
    end
    add_index :cats, :candidate_id
  end
end
