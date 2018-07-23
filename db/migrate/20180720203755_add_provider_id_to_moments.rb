class AddProviderIdToMoments < ActiveRecord::Migration[5.2]
  def up
    change_column :moments, :content_provider_id, 'integer USING CAST(content_provider_id AS integer)'
    add_column :moments, :provider_id, :string
    add_column :moments, :provider_author_id, :string
    remove_column :moments, :author_id
  end

  def down
    change_column :moments, :content_provider_id, :string
    remove_column :moments, :provider_id
    remove_column :moments, :provider_author_id
    add_column :moments, :author_id, :integer
  end
end
