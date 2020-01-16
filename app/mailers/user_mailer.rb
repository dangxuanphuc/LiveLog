class UserMailer < ApplicationMailer
  def account_activation email
    @email = email
    mail to: @email[:mail], subject: "Account activation"
  end
end
