require 'rails_helper'

RSpec.describe 'ユーザー管理機能1', type: :system do
  let!(:user){FactoryBot.create(:user, name: 'ユーザー', email: 'test@gmail.com',password: 'create+A',password_confirmation: 'create+A',admin: 'ユーザー')}
  describe '一般ユーザーのテスト' do
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした時' do
      it 'ログイン画面に推移する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end
  context '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
    before do
      visit new_session_path
      fill_in 'session_email', with: 'test@gmail.com'
      fill_in 'session_password', with: 'create+A'
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
    
    it 'タスク管理支援画面の文字が表示される' do
      click_on '詳細'
      visit tasks_path
      expect(page).to have_content "タスク管理支援画面"
    end
  end

  context '一般ユーザは管理画面にアクセスできないこと' do
    it '管理ユーザー画面ボタンをクリックすると管理者専用ページですと表示される' do
      click_link '管理ユーザ画面'
      visit tasks_path
      expect(page).to have_content "管理者専用ページです"
    end
  end

  context 'ログアウトができること' do
    it 'ログアウト後、推移した画面でログイン画面が表示される' do
      click_link "Logout"
      expect(page).to have_content "Log in"
    end
  end
end

  RSpec.describe 'ユーザー管理機能2', type: :system do
  let!(:user){FactoryBot.create(:user, name: 'ユーザー1', email: 'admin@test.com',password: 'create+A',password_confirmation: 'create+A',admin: '管理者') }
  let!(:second_user){FactoryBot.create(:user, name: 'ユーザー２', email: 'test_user@test.com',password: 'create+A',password_confirmation: 'create+A',admin: 'ユーザー')}
  before do
    visit new_session_path
    fill_in 'session_email', with: 'admin@test.com'
    fill_in 'session_password', with: 'create+A'
    click_on 'Log in'
  end

  describe 'セッション機能のテスト' do
    context 'ログインができること' do
      it 'ログイン後、ユーザの詳細画面が表示される' do
        expect(page).to have_content "のページ"
      end
    end
  end

  context '自分の詳細画面(マイページ)に飛べること' do
    it 'ログイン後推移した画面でログインしたユーザ名が表示されている' do
      expect(page).to have_content "#{user.name}"
    end
  end

  describe 'ユーザ登録のテスト' do
    context 'ユーザの新規登録ができること' do
      it 'ユーザーが新規登録される' do
        visit new_admin_user_path
        fill_in 'user[name]', with: 'user_test'
        fill_in 'user[email]', with: 'admin@test.com'
        fill_in 'user[password]', with: 'create+A'
        fill_in 'user[password_confirmation]', with: 'create+A'
        select '管理者', from: 'user[admin]'
        click_on '送信'
        user = User.select(:email)
        expect(user[0].email).to eq "admin@test.com"
      end
    end
  end 

  describe '管理画面のテスト' do
    context '管理ユーザは管理画面にアクセスできること' do
      it '管理画面に推移後、管理者画面が表示される' do
        click_link '管理ユーザ画面'
        expect(page).to have_content "ユーザ一一覧"
      end
    end
  end



end
