class AddFieldsToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :email, :string
    add_column :events, :responsable, :string
    add_column :events, :txtEnter, :string
    add_column :events, :txtAbout, :string
    add_column :events, :comission, :string
    add_column :events, :primaryColor, :string
    add_column :events, :secondaryColor, :string
    add_column :events, :status, :string
  end
end
