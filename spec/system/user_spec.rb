require 'rails_helper'

RSpec.describe 'ユーザー管理機能1', type: :system do
 
  describe '一般ユーザーのテスト1' do
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした時' do
      it 'ログイン画面に推移する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe '一般ユーザーのテスト2' do
    context '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'general@test.com'
        fill_in 'session[password]', with: '1234567+A'
        click_on 'Log in'
        visit new_task_path
        fill_in 'task[title]', with: 'タスク1'
        fill_in 'task[content]', with: 'コンテント1'
        fill_in 'task[expired_at]',with: '2022-04-12'
        select '未着手', from: 'task[status]'
        select '高', from: 'task[priority]'
        click_button '登録する'
        click_button 'タスク作成'
        visit tasks_path
      end

      it'タスク管理支援画面の文字が表示される' do
        click_on '詳細'
        visit tasks_path
        expect(page).to have_content "タスク管理支援画面"
      end
    end
  end

  describe '一般ユーザーテスト3' do
    context '一般ユーザは管理画面にアクセスできないこと' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'general@test.com'
        fill_in 'session_password', with: '1234567+A'
        click_on 'Log in'
      end
      it '管理ユーザー画面ボタンをクリックすると管理者専用ページですと表示される' do
        click_link '管理ユーザ画面'
        expect(page).to have_content "管理者専用ページです"
      end
    end
  end

  describe 'セッション機能のテスト' do
    before do
      visit new_session_path
      fill_in 'session_email', with: 'general@test.com'
      fill_in 'session_password', with: '1234567+A'
      click_on 'Log in'
    end
    context 'ログアウト' do
      it 'ログアウト後、推移した画面でログイン画面が表示される' do
        click_on 'Logout'
        expect(page).to have_content "Log in"
      end
    end
    context 'ログイン' do
      it 'ログイン後、ユーザの詳細画面が表示される' do
        expect(page).to have_content "のページ"
      end
    end
  end

  describe '管理者のテスト' do
    context 'ユーザの新規登録ができること' do
      before do 
        visit new_session_path
        fill_in 'session_email', with: 'admin@test.com'
        fill_in 'session_password', with: '1234567+A'
        click_on 'Log in'
      end
      it 'ユーザーが新規登録される' do
        visit new_admin_user_path
        fill_in 'user[name]', with: 'user1'
        fill_in 'user[email]', with: 'user@test.com'
        fill_in 'user[password]', with: '1234567+A'
        fill_in 'user[password_confirmation]', with: '1234567+A'
        select '管理者', from: 'user[admin]'
        click_on '送信'
        expect(page).to have_content 'ユーザ一一覧'
      end
    end

    context '管理ユーザは管理画面にアクセスできること' do
      it '管理画面に推移後、管理者画面が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@test.com'
        fill_in 'session[password]', with: '1234567+A'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content "ユーザ一一覧"
      end
    end
    
    context '管理ユーザはユーザの詳細画面にアクセスできること' do
      it '管理ユーザで一般ユーザの詳細画面へ画面推移する' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin2@test.com'
        fill_in 'session[password]', with: '1234567+A'
        click_on 'Log in'
        visit admin_user_path(3)
        expect(page).to have_content 'admin2@test.com'
        
      end
    end
    
    context '管理ユーザはユーザの編集画面からユーザを編集できること' do
      it '編集したメールアドレスが一覧に表示されている' do 
        visit new_session_path
        fill_in 'session[email]', with: 'admin2@test.com'
        fill_in 'session[password]', with: '1234567+A'
        click_on 'Log in'
        visit edit_admin_user_path(3)
        fill_in 'user[password]',with: '000000'
        fill_in 'user[password_confirmation]',with: '000000'
        click_on '更新する'
        expect(page).to have_content "ユーザー情報が更新されました"
      end
    end

    context '管理ユーザはユーザの削除をできること' do
      it '削除後、一覧からユーザが表示されなくなる' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin2@test.com'
        fill_in 'session[password]', with: '1234567+A'
        click_on 'Log in'
        visit admin_users_path
        first('.btn-outline-danger').click
        expect(page).not_to have_content "ユーザー一覧"
        visit admin_users_path
      end
    end
  end
end
