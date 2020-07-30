class AddTokenColumnToUserAndDropApiAccessTokenTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :api_access_tokens
    add_column :users, :api_access_token, :string
    add_index :users, :api_access_token

    User.all.each do |user|
      user.regenerate_api_access_token
    end
  end
  def down
    create_table :api_access_tokens do |t|
      t.integer :user_id
      t.string :key

      t.timestamps
    end
    remove_index :users, :api_access_token
    remove_column :users, :api_access_token
  end
end
