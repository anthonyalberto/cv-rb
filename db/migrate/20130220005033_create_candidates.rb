class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :current_status
      t.text :general_information

      t.timestamps
    end
  end
end
