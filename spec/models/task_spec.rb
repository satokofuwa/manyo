require 'rails_helper'
describe 'タスクモデル機能', type: :model do

  describe 'バリデーションのテスト' do

    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: nil)
        expect(task).not_to be_valid
      end
    end
     context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(content: nil)
        expect(task).not_to be_valid
      end
    end

    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功', content: '成功タスク')
        expect(task).to be_valid
      end
    end

      #タイトルで検索できる
      describe 'タスク管理機能', type: :system do 
        let!(:task){FactoryBot.create(:task, title: 'タスク1', content: 'コンテント1',status: '未着手') }
        let!(:second_task){FactoryBot.create(:task, title: 'タスク2', content: 'コンテント2',status: '着手中')}
        let!(:third_task){FactoryBot.create(:task, title: 'タスク3', content: 'コンテント3',status: '完了')}
  
          context 'タイトルであいまい検索をした場合' do
            it '検索キーワードを含むタスクで絞り込まれる' do
              visit tasks_path
              expect(Task.keyword('タスク1')).to include(task)
              expect(Task.keyword('タスク1')).not_to include(second_task)
              expect(Task.keyword('タスク1').count).to eq 1
  
            end
          end
          
          context 'ステータス検索をした場合' do
            it "ステータスに完全一致するタスクが絞り込まれる" do
              expect(Task.status_select('未着手')).to include(task)
              expect(Task.status_select('未着手')).not_to include(second_task)
              expect(Task.status_select('未着手').count).to eq 1
            end
          end
          context 'タイトルのあいまい検索とステータス検索をした場合' do
            it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
              expect(Task.keyword_status('タスク1', '未着手')).to include(task)
              expect(Task.keyword_status('タスク1', '未着手')).not_to include(second_task)
              expect(Task.keyword_status('タスク1', '未着手').count).to eq 1
            end
          end
        end
      end
  end
