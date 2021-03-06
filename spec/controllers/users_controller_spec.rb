require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET#new' do
    before { get :new }
    it 'ステータスコード200が返る' do
      expect(response.status).to eq 200
    end

    it 'new テンプレートが選択される' do
      expect(response).to render_template :new
    end
  end

  describe 'POST#create' do
    context '正常値' do
      let(:params) { { user: attributes_for(:user) } }

      it 'ステータスコード302が返る' do
        post :create, params: params
        expect(response.status).to eq 302
      end

      it 'showへリダイレクトする' do
        post :create, params: params
        expect(response).to redirect_to action: :show, id: assigns(:user).id
      end

      it 'ユーザがDBへ保存される' do
        expect { post :create, params: params }.to change(User, :count).by(1)
      end

      it 'ログインする' do
        post :create, params: params
        expect(session[:user_id]).to eq params[:user][:user_id]
      end
    end

    context '異常値' do
      let(:params) { { user: attributes_for(:invalid_user) } }

      it 'new テンプレートが選択される' do
        post :create, params: params
        expect(response).to render_template :new
      end

      it 'ユーザがDBへ保存されない' do
        expect { post :create, params: params }.not_to change(User, :count)
      end
    end
  end
end
