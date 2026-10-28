class Users::RegistrationsController < Devise::RegistrationsController
  def create
    password = SecureRandom.alphanumeric(8)
    build_resource(sign_up_params.merge(password: password, role: "owner"))

    if resource.save
      UserMailer.welcome(resource, password).deliver_now
      sign_up(resource_name, resource)
      redirect_to new_onboarding_path, notice: "Пароль от аккаунта отправили на #{resource.email}"
    else
      clean_up_passwords resource
      render :new, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :phone, :email, :terms)
  end
end
