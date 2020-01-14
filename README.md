[![Gem Version](https://badge.fury.io/rb/abilities.svg)](http://badge.fury.io/rb/abilities)
[![Code Climate](https://codeclimate.com/github/museways/abilities/badges/gpa.svg)](https://codeclimate.com/github/museways/abilities)
[![Build Status](https://travis-ci.org/museways/abilities.svg)](https://travis-ci.org/museways/abilities)
[![Dependency Status](https://gemnasium.com/museways/abilities.svg)](https://gemnasium.com/museways/abilities)

# Abilities

Authorization DSL to manage permissions in Ruby on Rails.

## Why

We did this gem to:

- Use a DSL instead of a plain class to simplify the syntax.
- Limit authorizations to only controllers and their views.

## Install

Add this line in your Gemfile:
```
gem 'abilities'
```

Then bundle:
```
$ bundle
```

## Configuration

Generate the definitions file:
```ruby
bundle exec rails g abilities:install
```

This will create two files.

```ruby
config/initializers/abilities.rb
config/abilities.rb
```

Set the user helper name to use in the controllers in the abilities.rb initializer:
```ruby
Abilities.configure do |config|
  config.helper = :user
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

We will mainly ensure compatibility to Rails, AWS, PostgreSQL, Redis, Elasticsearch and FreeBSD.

## Credits

This gem is maintained and funded by [museways](https://github.com/museways).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
