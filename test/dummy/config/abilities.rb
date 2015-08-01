Abilities.define do
  can :create, Post
  cannot :read, Post
  can 'destroy', Post.new if admin?
  can :edit, Post do |subject|
    subject.user == self
  end
  can :manage, User
  can :touch, :all
end
