class RenameUsersIdToUserIdInRecipes < ActiveRecord::Migration[7.0]
  def change
      rename_column :recipes, :users_id, :user_id
  end
end
