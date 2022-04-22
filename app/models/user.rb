class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :password, length: { minimum: 6 }
  validates :email, presence: true, length: { maximum: 255 },
                     format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :admin, presence: true
  enum admin: {"管理者": true, "ユーザー": false}

  has_secure_password 
  has_many :tasks, dependent: :destroy

  before_update :admin_update_check
  before_destroy :admin_delete_check

   private
   def admin_update_check
    if User.where(admin: true).count == 1 && self.admin
      throw(:abort) 
    end
  end

  def admin_delete_check
    if User.where(admin: true).count == 1 && self.admin
      throw(:abort)
      flash[:notice] ='最後のユーザーは削除できません'
    end
  end
  
end
