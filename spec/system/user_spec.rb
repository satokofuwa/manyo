require 'rails_helper'

RSpec.describe 'ユーザー管理機能1', type: :system do
  describe '管理者のテスト' do
    context 'ユーザの新規登録ができること' do
      before do 
        visit new_session_path
        fill_in 'session_email', with: 'admin@test.com'
        fill_in 'session_password', with: '1234567+A'
        click_on 'Log in'
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
  end