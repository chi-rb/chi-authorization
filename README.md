[![Gem Version](https://badge.fury.io/rb/abilities.svg)](http://badge.fury.io/rb/abilities)
[![Code Climate](https://codeclimate.com/github/mmontossi/abilities/badges/gpa.svg)](https://codeclimate.com/github/mmontossi/abilities) [![Build Status](https://travis-ci.org/mmontossi/abilities.svg)](https://travis-ci.org/mmontossi/abilities)
[![Dependency Status](https://gemnasium.com/mmontossi/abilities.svg)](https://gemnasium.com/mmontossi/abilities)

# Abilities

Minimalistic authorization inspired in cancan for rails.

## Install

Put this line in your Gemfile:
```ruby
gem 'abilities'
```

Then bundle:
```
$ bundle
```

## Configuration

Generate the abilities configuration file:
```
bundle exec rails g abilities:install
```

Ensure there is a current_user helper available in your controllers and views:
```ruby
class ApplicationController < ActionController::Base
  helper :current_user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
```

Add the abilities concern to the model:
```ruby
class User < ActiveRecord::Base
  include Abilities::Concern
end
```

## Usage

### Defining

All the abilities are defined in config/abilities.rb by can and cannot methods:
```ruby
Abilities.define do
  can :create, Post
  cannot :destroy, User unless admin?
  can :edit, Post do |subject|
    subject.user == self
  end
  can :manage, User
  can :touch, :all
end
```

If you want to load the abilities from the database you may do something like this:
```ruby
Abilities.define do
  permissions.each do |permission|
    can premissions.action, permissions.subject
  end
end
```

NOTE: Any method besides can and cannot references the current_user.

### Checking

#### Controllers

With the authorize! method Abilities::AccessDenied is raised if authorization fails:
```ruby
class PostsController < ApplicationController
  def edit
    @post = Post.find(params[:id])
    authorize! :edit, @post
  end
end
```

If you don't want an exception to be raised use can? and cannot? helpers:
```ruby
class UsersController < ApplicationController
  def edit
    @post = Post.find(params[:id])
    if can? :edit, @post
      @post.update post_params
    else
      # handle access denied
    end
  end
end
```

#### Views

The helpers can? and cannot? are available here too:
```erb
<% if can? :create, Post %>
  <%= link_to new_post_path %>
<% end %>
```

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
