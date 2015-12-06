class StaticPagesMailer < ApplicationMailer
  #  before_action :authenticate_user!
   def order_confirmation(user , ord)
     @user = user
     @order = ord
     @message = nil
     @order.each do |order|
      @message += order + "::"
     end
     puts @message

    #  mail(to: @user.email , subject: "test" ,)
   end

end










#user_signed_in?
#UserMailer.welcome_email(@user).deliver_later
