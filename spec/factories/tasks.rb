FactoryBot.define do
  factory :task, class: Task  do
    title { 'タスク１' }
    content { 'コンテント１' }
    expired_at {'2022.4.13'}
    status {'完了'}
  end
  factory :second_task, class: Task do
    title { 'タスク２' }
    content { 'コンテント２' }
    expired_at {'2022.4.14'}
    status{'完了'}
  end
  factory :third_task, class: Task do
    title { 'タスク3' }
    content { 'コンテント3' }
    expired_at {'2022.4.15'}
  end
end
