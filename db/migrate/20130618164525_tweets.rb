class Tweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string  :status
      t.integer :user_id
      
      t.timestamps
    end 
  end
end
