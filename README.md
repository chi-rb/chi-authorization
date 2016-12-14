[![Gem Version](https://badge.fury.io/rb/abilities.svg)](http://badge.fury.io/rb/abilities)
[![Code Climate](https://codeclimate.com/github/mmontossi/abilities/badges/gpa.svg)](https://codeclimate.com/github/mmontossi/abilities)
[![Build Status](https://travis-ci.org/mmontossi/abilities.svg)](https://travis-ci.org/mmontossi/abilities)
[![Dependency Status](https://gemnasium.com/mmontossi/abilities.svg)](https://gemnasium.com/mmontossi/abilities)

# Abilities

Authorization dsl to manage permissions in rails.

## Why

I did this gem to:

- Use a dsl instead of a plain class to simplify the syntax.
- Limit authorizations to only controllers and their views.

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

Generate the definitions file:
```
bundle exec rails g abilities:install
```

Ensure there is a current_user method in your controllers:
```ruby
class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end
```

## Usage

### Definitions

Use can and cannot methods to define the policies:
```ruby
Abilities.define do
  can :view, :any
  can :manage, User do |user|
    user == self
  end
  can :detroy, Product if admin?
end
```

NOTE: Methods besides can and cannot are sent to the current_user.

### Controllers

With the authorize! method Abilities::AccessDenied is raised if authorization fails:
```ruby
class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
    authorize! :edit, @user
  end
end
```

If you don't want an exception to be raised use can? and cannot? helpers:
```ruby
class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
    if can?(:edit, @user)
      @user.update post_params
    else
      # handle access denied
    end
  end
end
```

### Views

The helpers can? and cannot? are available in the controller views too:
```erb
<% if can?(:detroy, @product) %>
  <%= link_to product_path(@product), method: 'delete' %>
<% end %>
```

## Contributing

Any issue, pull request, comment of any kind is more than welcome!

I will mainly ensure compatibility to PostgreSQL, AWS, Redis, Elasticsearch, FreeBSD and Memcached. 

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
