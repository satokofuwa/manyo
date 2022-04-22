class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :password, length: { minimum: 6 }
  validates :email, presence: true, length: { maximum: 255 },
                     format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :admin, presence: true
  enum admin: {"管理者": true, "ユーザー": false}

  has_secure_password 
<<<<<<< HEAD
  has_many :tasks,dependent: :destroy
    accepts_nested_attributes_for :tasks

private
  def check_administrator_present?
    if User.where(admin: "管理者").count == 0
      raise ArgumentError, "管理者が0人になります。"
    end 
  end
=======
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
  
>>>>>>> step5
end
