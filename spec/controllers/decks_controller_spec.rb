require 'rails_helper'

RSpec.describe DecksController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #edit' do
    let(:user) { create_user(email: 'user@example.com', password: 'password') }
    let(:deck) { create_deck(user: user) }

    def create_user(email:, password:)
      User.create(email: email, password: password)
    end

    def create_deck(user:)
      Deck.create(title: 'Test Deck', description: 'Description', user: user)
    end

    context 'when user is authorized to edit the deck' do
      before do
        sign_in user
        get :edit, params: { id: deck.id }
      end

      it 'responds with a successful HTTP status' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'when user is not authorized to edit the deck' do
      let(:other_user) { create_user(email: 'other@example.com', password: 'password') }

      before do
        sign_in other_user
        get :edit, params: { id: deck.id }
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash alert message' do
        expect(flash[:alert]).to be_present
      end
    end

    context 'when user is not logged in' do
      before do
        get :edit, params: { id: deck.id }
      end

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
