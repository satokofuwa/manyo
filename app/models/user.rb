class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :password, length: { minimum: 6 }
  validates :email, presence: true, length: { maximum: 255 },
                     format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :admin, presence: true
  enum admin: {"管理者": true, "ユーザー": false}

  has_secure_password 
  has_many :tasks,dependent: :destroy
    accepts_nested_attributes_for :tasks

private
  def check_administrator_present?
    if User.where(admin: "管理者").count == 0
      raise ArgumentError, "管理者が0人になります。"
    end 
  end
end
