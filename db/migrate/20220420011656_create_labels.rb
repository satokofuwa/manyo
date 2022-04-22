class CreateLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :labels do |t|
      t.string :label_name
      t.index :label_name, unique: true
    end
  end
end
