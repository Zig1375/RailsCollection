class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    if user.id
      can :manage, Collection, user_id: user.id
      can :new, Collection
    end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
