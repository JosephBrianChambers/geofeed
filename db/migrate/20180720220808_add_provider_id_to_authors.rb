class AddProviderIdToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :provider_id, :string
  end
end
