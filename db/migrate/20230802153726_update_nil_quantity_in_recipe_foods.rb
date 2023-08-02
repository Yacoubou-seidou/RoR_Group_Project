class UpdateNilQuantityInRecipeFoods < ActiveRecord::Migration[7.0]
  def change
        RecipeFood.where(quantity: nil).update_all(quantity: 2)
  end
end
