Abilities.define do
  can :create, Post
  cannot :read, Post
  can 'destroy', Post.new if admin?
  can :update, Post do |post|
    post.user == self
  end
end
