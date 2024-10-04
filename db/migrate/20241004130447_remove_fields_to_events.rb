class RemoveFieldsToEvents < ActiveRecord::Migration[7.2]
  def change
    remove_column :events, :txtEnter, :string
    remove_column :events, :txtAbout, :string
  end
end
