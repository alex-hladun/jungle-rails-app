class Admin::SalesController < ApplicationController

  def index
    @sales = Sale.all

  end


  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end



  
end
