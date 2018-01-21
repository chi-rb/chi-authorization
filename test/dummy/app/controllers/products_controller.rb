class ProductsController < ApplicationController

  attr_accessor :user

  def show
    @user = User.new
    @product = Product.new
  end

end
