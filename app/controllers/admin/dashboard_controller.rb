class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]

  def show
    @data = Hash[
      "product_count" => Product.count(:name),
      "category_count" => Category.count(:name)
  ]
    puts @data
  end
end
