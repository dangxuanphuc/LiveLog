class UserMailer < ApplicationMailer
  def account_activation email
    @email = email
    mail to: @email[:mail], subject: "Account activation"
  end

  def password_reset pass_reset
    @pass_reset = pass_reset
    mail to: @pass_reset[:mail], subject: "Password reset"
  end
end
