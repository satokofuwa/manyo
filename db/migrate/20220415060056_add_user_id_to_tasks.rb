class AddUserIdToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :user_id, :bigint
    add_index  :tasks, :user_id, unique: true
  end
end
