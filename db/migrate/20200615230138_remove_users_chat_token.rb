class RemoveUsersChatToken < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :chat_token
  end
end
