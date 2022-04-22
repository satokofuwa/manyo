class Label < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tasks, through: :taggings
  validates :label_name, presence: true
end
