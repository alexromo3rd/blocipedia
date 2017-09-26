class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if User.user_roles == :admin
        scope.all
      else
        scope.where(private: false)
      end
    end
  end

  def update?
    user.admin? or not post.published?
  end
end
