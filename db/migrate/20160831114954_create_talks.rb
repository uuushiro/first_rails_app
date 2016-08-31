class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.text :content
      t.integer :to_id

      t.timestamps null: false
    end
  end
end
