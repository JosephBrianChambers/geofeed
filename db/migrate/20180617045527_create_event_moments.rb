class CreateEventMoments < ActiveRecord::Migration[5.2]
  def change
    create_table :event_moments do |t|
      t.integer :moment_id
      t.integer :event_id

      t.timestamps
    end

    add_index :event_moments, :moment_id
    add_index :event_moments, :event_id
  end
end
