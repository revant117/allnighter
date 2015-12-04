class StaticPagesController < ApplicationController

# before_action :authenticate_user!, only: [:mailer]

  def home
  	@hotel = Hotel.all
    @var = params[:id]
    @user = current_user


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
        session[:id] = @var
       @i = Hotel.find( @var)
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
    @ho= Hotel.find(session[:id])
    @item = @ho.items.map(&:name)
    @item.each do |item|
      if session.has_key?(item)
        @maildata[item] = session[item]

      end
    end
    @user = current_user
    puts @maildata

    #  StaticPagesMailer.order_confirmation(@user , @maildata).deliver
  end


end
