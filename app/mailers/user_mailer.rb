class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def welcome_email(user)
    @user = user
    @url = "http://social-network-157081.usw1.nitrousbox.com/"
    mail(to: @user.email, subject: 'Welcome to The Social Network!')
  end
end
