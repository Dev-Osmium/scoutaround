class EventPolicy < ApplicationPolicy
  def initialize(user, event)
    @user = user
    @event = event
  end

  def view?
    event.unit.members.include?(user)
  end

  def update?
    event.unit.role_for(user: user) == 'admin'
  end

  def publish?
    true
  end
end
