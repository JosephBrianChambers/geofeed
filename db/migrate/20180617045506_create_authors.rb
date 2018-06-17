class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :avatar_url
      t.string :name
      t.string :email
      t.integer :content_provider_id
      t.string :handle

      t.timestamps
    end

    add_index :authors, :content_provider_id
    add_index :authors, :name
    add_index :authors, :handle
    add_index :authors, :email
  end
end
