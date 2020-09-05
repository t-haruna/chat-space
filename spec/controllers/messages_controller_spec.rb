require 'rails_helper'

describe MessagesController do
  
  #テスト中に使用するインスタンスを定義
  let(:group) { create(:group) } #let:必要になったときに初めて生成される group = create(:group)※create(:クラス名)引数に書いているクラス名のインスタンスを、factory_botの記述をもとに作成
  let(:user) { create(:user) } #let:必要になったときに初めて生成される group = create(:group)

  describe 'Get#index' do
    context 'log in' do
      before do
        login user   #/spec/support/controller_macros.rbにて定義したメッソドを使用
        get :index, params: { group_id: group.id}  #擬似的にindexアクションを動かすリクエストをおこなう
                                                   #messageのルーティングはgroupにネストしているのでgrouo_idを含んだパスを生成
      end
      it "アクション内で定義しているインスタンス変数があるか@message" do
        expect(assigns(:message)).to be_a_new(Message)  #be_a_new:対象が引数で指定したクラスのインスタンスかつ未保存のレコードであるかどうか
      end
      it "アクション内で定義しているインスタンス変数があるか@group" do
        expect(assigns(:group)).to eq group
      end
      it "該当するビューが描画されているか" do
       expect(response).to render_template :index #esponse:example内でリクエストが行われた後の遷移先のビューの情報を持つインスタンス
                                                  #render_template:引数で指定されたアクションがリクエストされた時に自動的に遷移するビューを返す
      end
    end

    context 'not log in' do
      before do
        get :index, params:{ group_id: group.id}
      end
      it "意図したビューにリダイレクトできているか" do
        expect(response).to redirect_to(new_user_session_path)#redirect_to:引数にとったプレフィックスにリダイレクトした際の情報を返すマッチャ
      end
    end
  end



  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }#attributes_for：ハッシュのみを生成

    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        subject {                 #subjectでexpectの中身を別途記入
          post :create,
          params: params
        }

        it "メッセージの保存はできたのか" do
          expect{ subject }.to change(Message, :count).by(1)#changeマッチャ:Messageモデルのレコードの総数が1個増えたかどうかを確かめ
        end
        it "意図した画面に遷移しているか" do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }
        
        subject{                 #subjectでexpectの中身を別途記入
          post :create,
          params: invalid_params
        }

        it "メッセージの保存は行われなかったか" do
          expect{ subject }.not_to change(Message, :count)
        end

        it "意図したビューが描画されているか" do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'not log in' do

      it "意図した画面にリダイレクトできているか" do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path) 
      end
    end
  end

end

 