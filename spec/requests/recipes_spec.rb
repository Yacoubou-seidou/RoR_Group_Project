require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET /users/:user_id/recipes' do
    context 'when the user is logged in' do
      let(:user) { create(:user) }
      let!(:recipe) { create(:recipe, user:) }

      before do
        user.skip_confirmation!
        sign_in user
        get "/users/#{user.id}/recipes"
      end

      it 'returns status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'displays the user recipes' do
        expect(response.body).to include(recipe.name)
      end
    end

    context 'when the user is not logged in' do
      let(:user) { create(:user) }

      before { get "/users/#{user.id}/recipes" }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
