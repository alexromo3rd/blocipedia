class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis, dependent: :destroy
  after_initialize :set_as_standard, :if => :new_record?

  USER_ROLES = {
    :standard => 0,
    :premium => 10,
    :admin => 20
  }

  def downgrade!
    self.set_as_standard
    self.save!

    # publicize their wikis
    self.wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
  end

  def set_as_standard
    self.role = USER_ROLES[:standard]
  end

  def set_as_premium
    self.role = USER_ROLES[:premium]
  end

  def set_as_admin
    self.role = USER_ROLES[:admin]
  end

  def can_edit?(wiki)
    true if owns?(wiki) || admin?
  end

  def can_destroy?(wiki)
    true if owns?(wiki) || admin?
  end

  def can_resolve?(wiki)
    true if owns?(wiki) || admin?
  end

  def owns?(wiki)
    true if self.id == wiki.user_id
  end

  def admin?
    true if self.role_name == :admin
  end

  def role_name
    User.user_roles.key(self.role)
  end

  def self.user_roles
    USER_ROLES
  end
end
