class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.timestamps
    end
    add_index :events , :user_id
  end
end
