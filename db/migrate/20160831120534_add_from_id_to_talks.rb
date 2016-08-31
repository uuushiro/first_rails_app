class AddFromIdToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :from_id, :integer
  end
end
