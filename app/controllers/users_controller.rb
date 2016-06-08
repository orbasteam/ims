class UsersController < ApplicationController

  include Savable

  def update
    begin
      get_var.update! strong_params

      update_password

      flash[:success] = I18n.t('form.saved')
      after_save_success(get_var)

    rescue Exception => e
      redirect_to edit_user_path
    end

  end

  private

  def update_password
    if params[:user][:password].present? &&
        params[:user][:password_confirmation].present?

      @user.update_with_password(params[:user])

    end
  end

  def set_resource
    @user = current_user
  end

  def strong_params
    params.require('user').permit(:name, :password, :password_confirmation)
  end

end
