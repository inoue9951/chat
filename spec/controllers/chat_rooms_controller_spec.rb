require 'rails_helper'

RSpec.describe ChatRoomsController, type: :controller do
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
      let(:params) { { chat_room: attributes_for(:chat_room) } }

      it 'ステータスコード302が返る' do
        post :create, params: params
        expect(response.status).to eq 302
      end

      it 'showへリダイレクトする' do
        post :create, params: params
        expect(response).to redirect_to action: :show, id: assigns(:chat_room).id
      end

      it 'ユーザがDBへ保存される' do
        expect { post :create, params: params }.to change(ChatRoom, :count).by(1)
      end
    end

    context '異常値' do
      let(:params) { { chat_room: attributes_for(:invalid_chat_room) } }

      it 'newテンプレートが選択される' do
        post :create, params: params
        expect(response).to render_template :new
      end

      it 'DBへ登録されない' do
        expect { post :create, params: params }.not_to change(ChatRoom, :count)
      end
    end
  end
end
