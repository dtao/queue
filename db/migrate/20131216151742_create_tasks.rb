class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer  :user_id,     :null => false
      t.string   :description, :null => false
      t.text     :comments
      t.datetime :completed_at
      t.timestamps
    end

    add_index :tasks, :user_id
    add_index :tasks, :completed_at
  end
end
