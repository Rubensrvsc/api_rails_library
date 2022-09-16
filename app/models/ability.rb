# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return can [:read, :create, :update, :destroy], Book if user.role.type_role == 'admin'
    return can :read, Book if user.role.type_role == 'client'
  end
end
