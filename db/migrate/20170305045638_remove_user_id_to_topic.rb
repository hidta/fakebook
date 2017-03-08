class RemoveUserIdToTopic < ActiveRecord::Migration
  def change
    remove_column :topics, :user_id, :string
  end
end
