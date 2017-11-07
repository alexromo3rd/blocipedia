class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role_name == :premium || user.role_name == :admin
        scope.all
      else
        scope.where(private: [nil, false])
      end
    end
  end

  def index?
    user.present?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def destroy?
    user.present?
  end
end
