class HotelsController < ApplicationController

before_action :find_hotel , only: [:show  , :edit , :destroy , :update]

  def index
  end

  def new
  	@hotel = Hotel.new
  end

  def create
  	@hotel = Hotel.new(hotel_params)
  	if @hotel.save
  		redirect_to root_path
  		# redirect_to hotel_url(@hotel) same as
  	else
  		render 'new'
  	end
  end

  def show

   end

   def edit

   end

  def update
  	if @hotel.update(hotel_params)
  		redirect_to @hotel
  	else
  		render 'edit'
  	end

  end

  def destroy
  	@hotel.destroy
  	redirect_to root_path , notice: "deleted the hotel"
  end
private

def find_hotel
	@hotel = Hotel.find(params[:id])
end
def hotel_params
	params.require(:hotel).permit(:name , :contact , items_attributes: [:id , :name ,:description ,:image ,:price,:ava,:_destroy ])
end

end
