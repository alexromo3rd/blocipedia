class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis, dependent: :destroy
  attr_accessible :role

  USER_ROLES = {
    :standard => 0,
    :premium => 10,
    :admin => 20
  }

  def set_as_standard
    self.role = USER_ROLES[:standard]
  end

  def set_as_premium
    self.role = USER_ROLES[:premium]
  end

  def set_as_admin
    self.role = USER_ROLES[:admin]
  end
end
