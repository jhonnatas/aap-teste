class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :local
      t.date :period_start
      t.date :period_end
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
