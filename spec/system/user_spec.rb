require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザの新規登録ができること' do
      it 'ユーザーが新規登録される' do
        visit new_user_path
        fill_in 'name', with: 'create_user_test'
        fill_in 'email', with: 'create_user_test@gmail.com'
        fill_in 'password', with: 'create+A'
        fill_in 'password_confirmation', with: 'create+A'
        click_on '送信'
        user = User.select(:email)
        expect(user[0].email).to eq "create_user_test@gmail.com"
        #expect(user[0]).to have_attributes(email: "create_user_test@gmail.com")
        #expect(user).to include(:email => "create_user_test")
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移すること' do
      it 'ログイン画面に推移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン画面'
      end
    end
  end
  describe 'セッション機能のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    context 'ログインができること' do
      it 'ヘッダーメニューがログアウトに変わってる' do
        visit new_session_path
        fill_in 'email', with: 'admin@test.com'
        fill_in 'password', with: '1234567+A'
        click_on 'login'
        expect(page).to have_content "ログアウト"
      end
    end
    context '自分の詳細画面(マイページ)に飛べること' do
      it 'ログイン後推移した画面でログインしたユーザ名が表示されている' do
        visit new_session_path
        fill_in 'email', with: 'admin@test.com'
        fill_in 'password', with: '1234567+A'
        click_on 'login'
        expect(page).to have_content "#{user.name}"
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
      it '推移した画面にTODO LISTという表示がある' do
        visit new_session_path
        fill_in 'email', with: 'general@test.com'
        fill_in 'password', with: '1234567+A'
        click_on 'login'
        visit user_path(user.id)
        expect(page).to have_content "Todo list"
      end
    end
    context 'ログアウトができること' do
      it 'ログアウト後、推移した画面でログイン画面が表示される' do
        visit new_session_path
        fill_in 'email', with: 'general@test.com'
        fill_in 'password', with: '1234567+A'
        click_on 'login'
        click_on 'logout'
        expect(page).to have_content "ログイン画面"
      end
    end
  end
  describe '管理画面のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    context '管理ユーザは管理画面にアクセスできること' do
      it '管理画面に推移後、管理者画面が表示される' do
        visit new_session_path
        fill_in 'email', with: 'admin@test.com'
        fill_in 'password', with: '1234567+A'
        click_on 'login'
        click_on 'admin_page'
        expect(page).to have_content "管理者画面"
      end
    end
    context '一般ユーザは管理画面にアクセスできないこと' do
      it '管理画面にアクセス後、画面に管理者以外はアクセスできませんと表示される' do
        visit new_session_path
        fill_in 'email', with: 'general@test.com'
        fill_in 'password', with: '1234567+A'
        click_on 'login'
        visit admin_users_path
        expect(page).to have_content "管理者以外はアクセスできません"
      end
    end
    context '管理ユーザはユーザの新規登録ができること' do
      it 'new_admin_user_pathで作成したユーザがユーザ一覧画面に表示される' do
        visit new_session_path
        fill_in 'email', with: 'admin@test.com'
        fill_in 'password', with: '1234567+A'
        click_on 'login'
        visit new_admin_user_path
        fill_in 'name', with: 'create_user_test'
        fill_in 'email', with: 'create_user_test@gmail.com'
        fill_in 'password', with: 'create+A'
        fill_in 'password_confirmation', with: 'create+A'
        select '一般', from: 'user_admin'
        click_on '送信'
        expect(page).to have_content "create_user_test"
      end
    end
    context '管理ユーザはユーザの詳細画面にアクセスできること' do
      it 'adminユーザでgeneralユーザの詳細画面へ画面推移する' do
        visit new_session_path
        fill_in 'email', with: 'admin@test.com'
        fill_in 'password', with: '1234567+A'
        click_on 'login'
        visit admin_users_path
        click_on 'general'
        expect(page).to have_content "general@test.com"
      end
    end
    context '管理ユーザはユーザの編集画面からユーザを編集できること' do
      it '編集したメールアドレスが一覧に表示されている' do
        visit new_session_path
        fill_in 'email', with: 'admin@test.com'
        fill_in 'password', with: '1234567+A'
        click_on 'login'
        visit admin_users_path
        click_on 'general'
        click_on 'ユーザ情報を編集'
        page.accept_confirm '本当に編集していいですか？'
        fill_in 'name', with: 'create_user_test'
        fill_in 'email', with: 'create_user_test@gmail.com'
        fill_in 'password', with: 'create+A'
        fill_in 'password_confirmation', with: 'create+A'
        select '管理者', from: 'user_admin'
        click_on '送信'
        expect(page).to have_content "create_user_test@gmail.com"
      end
    end
    context '管理ユーザはユーザの削除をできること' do
      it '削除後、一覧からユーザが表示されなくなる' do
        visit new_session_path
        fill_in 'email', with: 'admin@test.com'
        fill_in 'password', with: '1234567+A'
        click_on 'login'
        visit admin_users_path
        click_on 'general'
        click_on '脱会'
        page.accept_confirm '本当に脱会していいですか？'
        expect(page).not_to have_content "general"
      end
    end
  end

end