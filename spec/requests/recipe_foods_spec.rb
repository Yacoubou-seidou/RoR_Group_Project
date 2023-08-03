require 'rails_helper'
RSpec.describe 'PublicRecipes', type: :request do
  describe 'GET /public_recipes' do
    context 'when the user is logged in' do
      let(:user) { create(:user) }

      before do
        user.skip_confirmation!
        sign_in user
        @public_recipe1 = create(:recipe, public: true, name: 'Public Recipe 1')
        @public_recipe2 = create(:recipe, public: true, name: 'Public Recipe 2')
        @private_recipe = create(:recipe, public: false, name: 'Private Recipe')
        get '/public_recipes'
      end

      it 'returns status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the public_recipes template' do
        expect(response).to render_template(:public_recipes)
      end

      it 'displays only public recipes' do
        expect(response.body).to include(@public_recipe1.name)
        expect(response.body).to include(@public_recipe2.name)
        expect(response.body).not_to include(@private_recipe.name)
      end
    end

    context 'when the user is not logged in' do
      before { get '/public_recipes' }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
