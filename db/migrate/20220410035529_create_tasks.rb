class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string "title"
      t.text "content"
      t.date "expired_at", defaulet:"2022-1-1", null: false
      t.index ["title"], name: "index_tasks_on_title", unique: true
      t.timestamps
    end
  end
end
