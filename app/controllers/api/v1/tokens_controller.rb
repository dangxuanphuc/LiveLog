class Api::V1::TokensController < Api::V1::ApplicationController
  before_action :authenticated_user, only: :destroy

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      if user.activated?
        @token = user.tokens.create
        @current_user = user
        render status: :created
      else
        render(
          plain: "Account not activated. Check your email for the activation link."
          status: :unauthorized
        )
      end
    else
      render(
        plain: "Invalid email/password combination"
        status: :unauthorized
      )
    end
  end

  def destroy
    @current_user.destroy_token(@token)
    @current_user = nil
  end
end
