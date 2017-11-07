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
    subject(:create_user) { post :create, params: params }

    context '正常値' do
      let(:params) { { user: FactoryGirl.attributes_for(:user) } }

      it 'ステータスコード200が返る' do
        expect(response.status).to eq 200
      end

      it 'show テンプレートが選択される' do
        expect(create_user).to redirect_to action: :show, id: assigns(:user).id
      end

      it 'ユーザがDBへ保存される' do
        expect { create_user }.to change(User, :count).by(1)
      end
    end

    context '異常値' do
      let(:params) { { user: FactoryGirl.attributes_for(:invalid_user) } }

      it 'new テンプレートが選択される' do
        expect(create_user).to render_template :new
      end

      it 'ユーザがDBへ保存されない' do
        expect { create_user }.not_to change(User, :count)
      end
    end
  end
end
