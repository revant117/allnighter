class ItemsController < ApplicationController
  def index
  end

  def new
  	@item = Item.new
  end

  def create
  	@item = Item.new(post_params)
  	if @item.save
  		redirect_to @item
  	else 
  		render 'new'
  	end
  end

  def show 
  	@item = Item.find(params[:id])
   end
private

def post_params
	params.require(:item).permit(:name , :description)
end

end
