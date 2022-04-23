class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.references :task, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true
    end
  end
end
