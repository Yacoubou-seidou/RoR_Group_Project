RSpec.describe 'Users', type: :request do
  describe 'GET /users/:user_id/foods' do
    context 'when the user is logged in' do
      let(:user) { create(:user) }
      let!(:food1) { create(:food, user:, name: 'Food 1') }
      let!(:food2) { create(:food, user:, name: 'Food 2') }
      let!(:other_user_food) { create(:food, name: 'Other User Food') }

      before do
        user.skip_confirmation!
        sign_in user
        get '/'
      end

      it 'returns status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the foods/index template' do
        expect(response).to render_template('foods/index')
      end

      it 'displays the user foods only' do
        expect(response.body).to include(food1.name)
        expect(response.body).to include(food2.name)
        expect(response.body).not_to include(other_user_food.name)
      end
    end

    context 'when the user is not logged in' do
      let(:user) { create(:user) }
      before { get '/' }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
