class StaticPagesController < ApplicationController
  def home
  	@item = Item.all
  end

  def help
  end
end
