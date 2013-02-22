class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.belongs_to :candidate, null: false
      t.string :name, null: false
      t.integer :year_from, null: false
      t.integer :year_to, null: false
      t.text :description
      t.text :key_facts
      t.string :url

      t.timestamps
    end
    add_index :experiences, :candidate_id
  end
end
