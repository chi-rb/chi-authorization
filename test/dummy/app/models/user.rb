class User < ActiveRecord::Base
  include Abilities::Capable
end
