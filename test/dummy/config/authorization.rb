Chi::Authorization.define do |current_user|

  can :touch, :any
  can :manage, User, if: ->(user) {
    user == current_user
  }
  can :create, [Product, User]
  can %i(view list), Product

  scope unless: ->{ current_user.admin? } do
    cannot :detroy, Product
  end

end
