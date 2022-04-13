require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  
  let!(:task){FactoryBot.create(:task, title: 'タスク1', content: 'コンテント1') }
  let!(:second_task){FactoryBot.create(:task, title: 'タスク2', content: 'コンテント2')}
  let!(:third_task){FactoryBot.create(:task, title: 'タスク3', content: 'コンテント3')}

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスク.終了期限.ステータスが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: '部屋の片付け'
        fill_in 'task[content]', with: 'リビングと和室の片付けをする'
        fill_in 'task[expired_at]',with: '2022-04-12'
        click_button '登録する'
      end
    end
  end

  before do
    visit tasks_path
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
        it '登録された一覧ページに表示されているかを確認する'do
          expect(page).to have_content 'タスク1'
          expect(page).to have_content 'タスク2'
          expect(page).to have_content 'タスク3'
        end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.test')
        expect(task_list[0]).to have_content 'タスク名：タスク3'
        expect(task_list[1]).to have_content 'タスク名：タスク2'
        expect(task_list[2]).to have_content 'タスク名：タスク1'
      end
    end
  end

  describe '詳細表示機能' do
    let(:task){FactoryBot.create(:task, title: '会議',content: '10時集合')}
    context '任意のタスク詳細画面に遷移した場合' do
      before do
        visit tasks_path(task)
      end
      it '登録されたタスクが詳細ページに表示されているかを確認する' do
        expect(page).to have_content '会議'
      end
    end
  end
end