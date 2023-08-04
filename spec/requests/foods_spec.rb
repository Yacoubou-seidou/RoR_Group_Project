require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  describe 'GET /foods' do
    context 'when the user is logged in' do
      let(:user) { create(:user) }

      before do
        user.skip_confirmation!
        sign_in user
        get '/foods'
      end

      it 'returns status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'displays the user foods' do
        expect(response.body).to include('Food List')
      end
    end

    context 'when the user is not logged in' do
      before { get '/foods' }
      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
