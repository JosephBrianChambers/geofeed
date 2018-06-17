class AddEventIdToMoments < ActiveRecord::Migration[5.2]
  def change
    add_column :moments, :event_id, :integer
    add_index :moments, :event_id
  end
end
