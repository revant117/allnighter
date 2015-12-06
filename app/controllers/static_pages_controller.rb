class StaticPagesController < ApplicationController

before_action :auth, only: [:mailer]

  def home
  	@hotel = Hotel.find(8)
    # @var = params[:id]
    @user = current_user
    #================================
    @sand = @hotel.items.where(:id => 33..39)
    @bur = @hotel.items.where(:id => 40..43)
    @ind = @hotel.items.where(:id => 44..45)
    @par = @hotel.items.where(:id => 46..48)
    @mag = @hotel.items.where(:id => 49..48)
    @drinks = @hotel.items.where(:id => 51..53 ,:id => 56..57)
    #================================


    @itemId = params[:itemId]
    @qty = params[:quantity]
    @itemName = params[:ItemName]


    puts @qty
    puts @var
    puts @itemId
    if @qty && @itemId

      if session.has_key?(@itemName)

        puts   session[@itemName]
        puts   @qty
        @t =  Integer(session[@itemName]) + Integer(@qty)
        puts @t

        session[@itemName] = @t




      else
        session[@itemName] = @qty


      end

      respond_to do |format|
        format.json do
           render json: {
             qty:@qty,
             id:@itemId
           }.to_json
         end
        end
    elsif @var
        # session[:id] = @var
       @i = Hotel.find(8)
       @item = @i.items.map(&:name)
       @item.each do |item|
         if session.has_key?(item)
           session[item] = nil

         end
       end
       puts @i
       respond_to do |format|
         format.html
         format.js
       end
    end

  end


  def help

  end

  def mailer
    puts "yay"
    @maildata = Hash.new("not there")
    puts session[:id]
    @ho= Hotel.find(8)
    @item = @ho.items.map(&:name)
    @item.each do |item|
      if session.has_key?(item)
        @maildata[item] = session[item]

      end
    end
    @user = current_user
    puts @maildata

     StaticPagesMailer.order_confirmation(@user , @maildata)#.deliver
  end

  private

  def auth
    if !current_user
      redirect_to signIn_path
    end
  end


end
