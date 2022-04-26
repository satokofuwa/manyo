FactoryBot.define do
  factory :label do
    id { 1 }
    label_name { "label0" }
  end

  factory :second_label, class: Label do
    id { 2 }
    label_name {'label1'}
  end
end
