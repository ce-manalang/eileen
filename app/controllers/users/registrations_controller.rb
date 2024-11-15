class Users::RegistrationsController < Devise::RegistrationsController
  # Redirect to root if sign-up is disabled
  def new
    redirect_to root_path, alert: "Sign up is not available."
  end
  def create
    redirect_to root_path, alert: "Sign up is not available."
  end
end