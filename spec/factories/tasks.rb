FactoryBot.define do
  factory :task, class: Task  do
    title { 'タスク１' }
    content { 'コンテント１' }
  end
  factory :second_task, class: Task do
    title { 'タスク２' }
    content { 'コンテント２' }
  end
end
