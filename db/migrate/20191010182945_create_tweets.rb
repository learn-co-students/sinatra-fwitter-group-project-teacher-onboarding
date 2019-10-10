class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
