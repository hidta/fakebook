class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :content
      t.string :topic_img
      t.string :user_id

      t.timestamps null: false
    end
  end
end
