require 'rails_helper'
RSpec.describe 'GeneralShoppingList', type: :request do
  describe 'GET /general_shopping_list' do
    context 'when the user go to general shopping' do
      let(:user) { create(:user) }

      before do
        user.skip_confirmation!
        sign_in user
        @public_recipe1 = create(:recipe, public: true, name: 'Public Recipe 1')
        @public_recipe2 = create(:recipe, public: true, name: 'Public Recipe 2')
        @food1 = create(:food, user:, name: 'Food 1')
        @food2 = create(:food, user:, name: 'Food 2')
        @recipe_food1 = create(:recipe_food, food_id: @food1.id, recipe_id: @public_recipe1.id)
        @recipe_food2 = create(:recipe_food, food_id: @food2.id, recipe_id: @public_recipe2.id)
        get '/general_shopping_list'
      end

      it 'returns status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the general_shopping_list template' do
        expect(response).to render_template(:general_shopping_list)
      end

      it 'displays Foods recipes' do
        expect(response.body).to include('Shopping List')
        expect(response.body).to include(@food1.name)
        expect(response.body).to include(@food2.name)
      end
    end

    context 'when the user is not logged in' do
      before { get '/general_shopping_list' }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
