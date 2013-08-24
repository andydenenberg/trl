class UserMailer < ActionMailer::Base
  default :from => "tim@denenberg.net"
  
  def welcome_email(user)
    mail(:to => user.email, :subject => "Welcome to our Colaboration!")
  end
end