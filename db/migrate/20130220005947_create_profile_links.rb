class CreateProfileLinks < ActiveRecord::Migration
  def change
    create_table :profile_links do |t|
      t.belongs_to :candidate, null: false
      t.string :name, null: false
      t.string :url, null: false

      t.timestamps
    end
    add_index :profile_links, :candidate_id
  end
end
