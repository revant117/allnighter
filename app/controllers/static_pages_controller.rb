class StaticPagesController < ApplicationController
  def home
  	@hotel = Hotel.all
    @var = params[:id]
    @qty = params[:quantity]
    @itemId = params[:itemId]
    puts @qty
    puts @var
    puts @item
    puts @itemId
    if @qty && @itemId
      respond_to do |format|
        format.json do
           render json: {
             qty:@qty,
             id:@itemId
           }.to_json
         end
        end
    elsif @var
       @i = Hotel.find( @var)
       puts @i
       respond_to do |format|
         format.html
         format.js
       end
    end
  end


  def help
  end


end
