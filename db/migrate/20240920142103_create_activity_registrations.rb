class CreateActivityRegistrations < ActiveRecord::Migration[7.2]
  def change
    create_table :activity_registrations do |t|
      t.string :status, default: "pending"
      t.references :user, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
