class StaticPagesMailer < ApplicationMailer
  #  before_action :authenticate_user!
   def order_confirmation(a,b,c,d)
    #  @user = user

     @msg = b + "::" + c + "::" + d + ":: order ::" + a
    #  @message = nil
    #  @order.each do |order|
    #   @message += order + "::"
    #  end
    #  puts @message
    puts @msg

     mail(to: "revantjha.94@gmail.com" , subject: "test" , body: @msg)

  

   end

end










#user_signed_in?
#UserMailer.welcome_email(@user).deliver_later
