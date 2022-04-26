require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  
  before do
    visit new_session_path
    fill_in 'session[email]', with: 'admin@test.com'
    fill_in 'session[password]', with: '1234567+A'
    click_on 'Log in'
  end
  describe 'ラベルのテスト' do
    context 'ラベルを新規作成した場合' do

      it 'タスク管理支援画面にタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'タスク1'

        fill_in 'task[content]', with: 'コンテント1'
        fill_in 'task[expired_at]',with: '2022-04-12'
        select '未着手', from: 'task[status]'
        check 'label0'
        click_button '登録する'
        expect(page).to have_content 'label0'
      end
    end
    context 'ラベルを複数選択した場合' do
      it 'タスク管理支援画面に複数タスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'タスク1'
        fill_in 'task[content]', with: 'コンテント1'
        fill_in 'task[expired_at]',with: '2022-04-12'
        select '未着手', from: 'task[status]'
        check 'label0'
        check 'label1'
        click_button '登録する'
        expect(page).to have_content 'label0'
        expect(page).to have_content 'label1'
      end
    end
    context 'ラベル検索した場合' do
      it 'タスク管理支援画面にタスクに紐づいているラベルが表示される' do
        visit tasks_path
        select 'label0', from: 'task[label_ids]'
        click_on 'Search'
        expect(page).to have_content "label0" 
      end
    end
    context 'ラベル検索した場合' do
      it 'タスク詳細画面にタスクに紐づいているラベル一覧を出力する' do
        visit new_task_path
        fill_in 'task[title]', with: 'タスク1'
        fill_in 'task[content]', with: 'コンテント1'
        fill_in 'task[expired_at]',with: '2022-04-12'
        select '未着手', from: 'task[status]'
        check 'label0'
        check 'label1'
        click_button '登録する'
        visit tasks_path
        click_on '詳細'

        expect(page).to have_content "関連タグ" 
        expect(page).to have_content "label0" 
      end
    end
    
  end
end