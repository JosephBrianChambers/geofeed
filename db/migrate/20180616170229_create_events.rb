class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.st_polygon :loc_fence, srid: 3857
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end

    add_index :events, :loc_fence, using: :gist
    add_index :events, :start_time
    add_index :events, :end_time
  end
end
