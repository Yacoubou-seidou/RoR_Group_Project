class ChangeNameDataTypeInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :name, :string, limit: 255
  end
end
