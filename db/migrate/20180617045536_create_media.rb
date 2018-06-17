class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.string :url
      t.integer :moment_id

      t.timestamps
    end

    add_index :media, :moment_id
  end
end
