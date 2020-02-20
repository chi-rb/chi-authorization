[![Gem Version](https://badge.fury.io/rb/chi-authorization.svg)](http://badge.fury.io/rb/chi-authorization)
[![Code Climate](https://codeclimate.com/github/chi-rb/chi-authorization/badges/gpa.svg)](https://codeclimate.com/github/chi-rb/chi-authorization)
[![Build Status](https://travis-ci.org/chi-rb/chi-authorization.svg)](https://travis-ci.org/chi-rb/chi-authorization)

# Authorization

DSL to manage user permissions in Rails.

## Why

I want to:

- Use a DSL instead of a plain class.
- Limit authorizations to only controllers and their views.

## Install

Put this line in your Gemfile:
```ruby
gem 'chi-authorization'
```

Then bundle:
```
$ bundle
```

## Configuration

Generate the policies file:
```
bin/rails g chi:authorization:install
```

Set the user `helper_name` inisde the generated `intializers/authorization.rb`:
```ruby
Chi::Authorization.configure do |config|
  config.helper_name = :current_user
end
```

## Usage

### Policies

Use `can` and `cannot` methods to define the policies inside the generated `config/authorization.rb`:
```ruby
Chi::Authorization.define do |current_user|
  can :view, :any
  can :manage, User, if: ->(user) {
    user == current_user
  }

  scope unless: ->{ current_user.admin? } do
    can :detroy, Product
  end
end
```

### Controllers

Using `authorize!` method `Chi::Exceptions::AccessDenied` is raised if authorization fails:
```ruby
class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
    authorize! :edit, @user
  end
end
```

If you don't want an exception to be raised use `can?` and `cannot?` instead:
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

The helpers `can?` and `cannot?` are available in the controller views too:
```erb
<% if can?(:detroy, @product) %>
  <%= link_to product_path(@product), method: 'delete' %>
<% end %>
```

## Contributing

Any issue, pull request, comment of any kind is more than welcome!

## Credits

This gem is funded and maintained by [mmontossi](https://github.com/mmontossi).

With the sponsorship of:

[![Occam Logo](https://www.occam.global/wp-content/uploads/2018/01/Occam_V1_170px.png)](https://www.occam.global)

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
