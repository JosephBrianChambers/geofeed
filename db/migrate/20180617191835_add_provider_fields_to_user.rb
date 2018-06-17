class AddProviderFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider_access_token_id, :integer
    add_index :users, :provider_access_token_id
  end
end
