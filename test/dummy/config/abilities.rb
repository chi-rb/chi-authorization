Abilities.define do
  can :touch, :any
  can :manage, User do |user|
    user == self
  end
  can :create, [Product, User]
  can %i(view list), Product
  cannot :detroy, Product unless admin?
end
