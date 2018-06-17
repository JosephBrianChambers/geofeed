class CreateMoments < ActiveRecord::Migration[5.2]
  def change
    create_table :moments do |t|
      t.st_point :loc, srid: 3857
      t.string :title
      t.string :author_id
      t.text :caption
      t.string :content_provider_id
    end

    add_index :moments, :loc, using: :gist
    add_index :moments, :author_id
  end
end
