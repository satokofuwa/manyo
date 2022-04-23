class Task < ApplicationRecord
  validates :title, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 100}
  
  belongs_to :user
  has_many :taggings,dependent: :destroy
  has_many :labels, through: :taggings
  
  enum status: {"未着手": 0, "着手中": 1, "完了": 2}
  enum priority: {"低": 0, "中": 1, "高": 2}

  scope :keyword, -> (keyword) { where('title LIKE ?', "%#{keyword}%") }
  scope :status_select, -> (status_select) { where(status: status_select )}
  scope :keyword_status, -> (keyword, status_select){keyword(keyword).status_select(status_select)}
  scope :priority_sort, ->  { reorder(priority: "DESC" )}
end
