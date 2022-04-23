require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task){FactoryBot.create(:task, title: 'タスク1', content: 'コンテント1',expired_at: '2022-06-01',status: '未着手',priority: '高') }
  let!(:second_task){FactoryBot.create(:task, title: 'タスク2', content: 'コンテント2',expired_at: '2023-06-01', status: '着手中',priority: '中')}
  let!(:third_task){FactoryBot.create(:task, title: 'タスク3', content: 'コンテント3',status: '完了',priority: '低')}

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスク.終了期限.ステータスが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'タスク1'
        fill_in 'task[content]', with: 'コンテント1'
        fill_in 'task[expired_at]',with: '2022-04-12'
        select '未着手', from: 'task[status]'
        click_button '登録する'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      visit tasks_path
    end
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
        expect(task_list[0]).to have_content 'タスク名:タスク3'
        expect(task_list[1]).to have_content 'タスク名:タスク2'
        expect(task_list[2]).to have_content 'タスク名:タスク1'
      end
    end
    context '終了期限でソートするのボタンを押した場合' do
      it '終了期限が一番新しいタスクが一覧の一番上に表示される' do
        visit tasks_path(sort_expired: "true")
        task_list = all('.expired')
        expect(task_list[0]).to  have_content '終了期限:2023-06-01'
        expect(task_list[1]).to  have_content '終了期限:2022-06-01'
      end
    end

    context '優先度のボタンを押した場合' do
      it '優先度の高いタスクが一覧の一番上に表示される' do
        visit tasks_path(priority_sort: "true")
        task_list = all('.priority')
        expect(task_list[0]).to  have_content '高'
      end
    end
  end 

  describe '検索機能' do
    before do
      visit tasks_path
    end
    
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'task[search]', with: 'タスク1'
        click_button 'Search'
        expect(page).to have_content 'タスク名:タスク1'
        expect(page).to have_no_content 'タスク名:タスク2'
        expect(page).to have_no_content 'タスク名:タスク3'
      end
    end

    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '着手中', from: 'task[status]'
        click_on 'Search'
        expect(page).to  have_content 'ステータス:着手中'
        expect(page).to have_no_content 'ステータス:未着手'
        expect(page).to have_no_content 'ステータス:完了'
      end
    end

    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'task[search]', with: 'タスク2'
        select '着手中', from: 'task_status'
        click_on 'Search'
        expect(page).to have_content 'タスク名:タスク2'
        expect(page).to have_content 'ステータス:着手中'
        expect(page).to have_no_content 'タスク名:タスク1'
        expect(page).to have_no_content 'ステータス:未着手'
        expect(page).to have_no_content 'ステータス:完了'
      end
    end
  end  

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      before do
        visit tasks_path(task)
      end
      it '登録されたタスクが詳細ページに表示されているかを確認する' do
        expect(page).to have_content 'タスク名:タスク1'
        expect(page).to have_content '内容:コンテント1'
      end
    end
  end
end