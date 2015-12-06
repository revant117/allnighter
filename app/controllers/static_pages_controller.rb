class StaticPagesController < ApplicationController

# before_action :auth, only: [:mailer]

  def home
  	# @hotel = Hotel.find(8)
    # # @var = params[:id]
    # @user = current_user
    # #================================
    # @sand = @hotel.items.where(:id => 33..39)
    # @bur = @hotel.items.where(:id => 40..43)
    # @ind = @hotel.items.where(:id => 44..45)
    # @par = @hotel.items.where(:id => 46..48)
    # @mag = @hotel.items.where(:id => 49..50)
    # @drinks = @hotel.items.where(:id => 51..53 ,:id => 56..57)
    # #================================

    @qty = params[:quantity]
    @itemName = params[:ItemName]
    @price = params[:price]
    @remove = params[:remove]
    # @items = params[:items];
    puts "1"
    # puts params[:items].to_s
    @item = params[:items].to_s
    puts @item

    session[:item] = @item
    if @qty && @itemName

      # if session.has_key?(@itemName)
      #   @t =  Integer(session[@itemName]) + Integer(@qty)
      #   session[@itemName] = @t
      # else
      #   session[@itemName] = @qty
      # end
      respond_to do |format|
        format.json do
           render json: {
             qty:@qty,
             name:@itemName,
             price:@price,
           }.to_json
         end
        end
    elsif @var
        # session[:id] = @var
       @i = Hotel.find(8)
      #  @item = @i.items.map(&:name)
      #  @item.each do |item|
      #    if session.has_key?(item)
      #      session[item] = nil
       #
      #    end
      #  end
       respond_to do |format|
         format.html
         format.js
       end
    end

  end


  def help

  end

  def mailer
      @maildata = session[:item]
      #  @user = current_user
      @name = params[:name]
      @phone = params[:phone]
      @address = params[:add]

      if @name && @phone && @address then

       StaticPagesMailer.order_confirmation(@maildata , @name , @phone, @address).deliver
           @message = "Order sent"
      end


  end



  private
  #
  # def auth
  #   if !current_user
  #     redirect_to signIn_path
  #   end
  # end

  # def sendMail(a,b,c,d)
  #    StaticPagesMailer.order_confirmation(a,b,c,d).deliver
  # end


end
