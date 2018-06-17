class CreateContentProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :content_providers do |t|
      t.string :name
      t.string :code

      t.timestamps
    end

    add_index :content_providers, :code
  end
end
