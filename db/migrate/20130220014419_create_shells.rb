class CreateShells < ActiveRecord::Migration
  def change
    create_table :shells do |t|
      t.text :code_buffer
      t.belongs_to :recruiter

      t.timestamps
    end
    add_index :shells, :recruiter_id
  end
end
