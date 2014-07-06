Abilities.define do
  can :create, Post
  cannot :read, Post
  can 'destroy', Post.new if admin?
  can :edit, Post do |post|
    post.user == self
  end
  can :manage, User
  can :touch, :all
end
