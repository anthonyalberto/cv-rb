class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.belongs_to :candidate, null: false
      t.string :name, null: false
      t.date :date_from, null: false
      t.date :date_to, null: false
      t.text :description
      t.string :url

      t.timestamps
    end
    add_index :educations, :candidate_id
  end
end
