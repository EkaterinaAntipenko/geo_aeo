class UserMailer < ApplicationMailer
  def welcome(user, password)
    @user = user
    @password = password
    mail to: user.email, subject: "Доступ к личному кабинету Okula"
  end
end
