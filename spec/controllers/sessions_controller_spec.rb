require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET#new' do
    before { get :new }
    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'newテンプレートが選択される' do
      expect(response).to render_template :new
    end
  end

  describe 'POST#create' do
    before { post :create, params: params }

    let(:user) { FactoryGirl.create(:user) }

    context 'ログインが成功した場合' do
      let(:params) { { session: { user_id: user.user_id, password: user.password } } }

      it 'ステータスコード200が返ってくる' do
        expect(response.status).to eq 302
      end

      it 'users#showへリダイレクトする' do
        expect(response).to redirect_to controller: :users, action: :show, id: assigns(:user).id
      end

      it 'session[:user_id]にuser_idが格納されている' do
        expect(session[:user_id]).to eq user.user_id
      end
    end

    context 'ログインが失敗した場合' do
      let(:params) { { session: { user_id: '', password: '' } } }

      it 'newテンプレートをレンダリングする' do
        expect(response).to render_template :new
      end

      it 'session[:user_id]にuser_idが格納されていない' do
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe 'Delete#destroy' do
    before do
      post :create, params: params
      delete :destroy
    end

    let(:user) { FactoryGirl.create(:user) }
    let(:params) { { session: { user_id: user.user_id, password: user.password } } }

    it 'session[:user_id]に何も格納されていない' do
      expect(session[:user_id]).to be_nil
    end

    it 'newへリダイレクトする' do
      expect(response).to redirect_to action: :new
    end
  end
end
