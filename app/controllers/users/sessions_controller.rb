class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def downgrade
    @user = current_user
    @user.downgrade!

    if @user.save
      flash[:notice] = "You have been downgraded to Standard user."
      redirect_to root_path
    else
      flash.now[:alert] = "Error downgrading. Please try again."
      render :edit
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
