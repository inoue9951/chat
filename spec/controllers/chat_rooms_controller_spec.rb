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
    let(:user) { create(:user) }

    before do
      session[:user_id] = user.user_id
      session[:id] = user.id
    end

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

      it 'チャットルームがDBへ保存される' do
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

  describe 'PATCH#update' do
    let(:user) { create(:user) }
    let(:chat_room) { create(:chat_room) }

    before do
      session[:user_id] = user.user_id
      session[:id] = user.id
    end

    context 'UserとChatRoomの関連が存在しない場合' do
      it '中間テーブルに登録される' do
        expect { patch :update, params: { id: chat_room.id } }.to change(chat_room.users, :count).by(1)
      end
    end

    context 'UserとChatRoomの関連が存在する場合' do
      it '中間テーブルに登録されない' do
        chat_room.users << user
        expect { patch :update, params: { id: chat_room.id } }.not_to change(chat_room.users, :count)
      end
    end

    it 'showへリダイレクトされる' do
      patch :update, params: { id: chat_room.id }
      expect(response).to redirect_to action: :show, id: chat_room.id
    end
  end

  describe 'DELETE#destroy' do
    let(:user) { create(:user) }
    let(:chat_room) { create(:chat_room) }

    before do
      session[:user_id] = user.user_id
      session[:id] = user.id
      chat_room.users << user
    end

    it 'チャットルームが削除される' do
      expect { delete :destroy, params: { id: chat_room.id } }.to change(ChatRoom, :count).by(-1)
    end

    it 'UserとChatRoomの関連が削除される' do
      expect { delete :destroy, params: { id: chat_room.id } }.to change(user.chat_rooms, :count).by(-1)
    end

    it 'users#showへリダイレクトされる' do
      delete :destroy, params: { id: chat_room.id }
      expect(response).to redirect_to controller: :users, action: :show, id: session[:id]
    end
  end

  describe 'DELETE#leave' do
    let(:user) { create(:user) }
    let(:chat_room) { create(:chat_room) }

    before do
      session[:user_id] = user.user_id
      session[:id] = user.id
    end

    context 'UserとChatRoomの関連が存在する場合' do
      it '関連が削除される' do
        chat_room.users << user
        expect { delete :leave, params: { id: chat_room.id } }.to change(chat_room.users, :count).by(-1)
      end
    end

    it 'users#showへリダイレクトされる' do
      delete :leave, params: { id: chat_room.id }
      expect(response).to redirect_to controller: :users, action: :show, id: session[:id]
    end
  end
end
