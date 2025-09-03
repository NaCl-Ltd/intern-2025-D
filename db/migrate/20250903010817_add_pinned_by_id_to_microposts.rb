class AddPinnedByIdToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :pinned_by_id, :integer
    add_index :microposts, :pinned_by_id
  end
end
