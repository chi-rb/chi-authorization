class User < ActiveRecord::Base
  include Abilities::Concern
end
