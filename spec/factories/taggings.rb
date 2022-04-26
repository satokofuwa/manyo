FactoryBot.define do
  factory :tagging do
    factory :label do
      task_id { 1 }
      label_id { 1 }
    end
  end
end
