class CreateMoments < ActiveRecord::Migration[5.2]
  def change
    create_table :moments do |t|
      t.st_point :loc, srid: 3857
    end

    add_index :moments, :loc, using: :gist
  end
end
