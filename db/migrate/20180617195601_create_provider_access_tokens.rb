class CreateProviderAccessTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :provider_access_tokens do |t|
      t.integer :user_id
      t.string :token
      t.datetime :expires_at
      t.integer :content_provider_id

      t.timestamps
    end

    add_index :provider_access_tokens, :user_id
    add_index :provider_access_tokens, :content_provider_id
    add_index :provider_access_tokens, :expires_at
  end
end
