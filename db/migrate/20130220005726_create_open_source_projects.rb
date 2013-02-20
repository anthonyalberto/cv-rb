class CreateOpenSourceProjects < ActiveRecord::Migration
  def change
    create_table :open_source_projects do |t|
      t.belongs_to :candidate, null: false
      t.string :name, null: false
      t.text :description
      t.string :url

      t.timestamps
    end
    add_index :open_source_projects, :candidate_id
  end
end
