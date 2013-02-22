class CreateFunnyLinks < ActiveRecord::Migration
  def change
    create_table :funny_links do |t|
      t.belongs_to :candidate, null: false
      t.stirng :name, null: false
      t.string :url, null: false

      t.timestamps
    end
    add_index :funny_links, :candidate_id
  end
end
