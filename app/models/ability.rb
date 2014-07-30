class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)
    if user.is? "admin"
        can :manage, :all
    elsif user.is? "default"
        can :read, Post
        can :manage, Comment
    else
        can :read, Post
    end
  end
end
