class CreateActivities < ActiveRecord::Migration[7.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :title
      t.string :speaker
      t.string :local
      t.datetime :period_start
      t.datetime :period_end
      t.string :certificate_hours
      t.boolean :subscriptions_open
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
