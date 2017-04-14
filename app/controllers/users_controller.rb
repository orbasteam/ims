class UsersController < AdminController

  include Savable

  def update
    begin

      ActiveRecord::Base.transaction do
        get_var.update! strong_params

        update_password
      end

      flash[:success] = I18n.t('form.saved')
      redirect_to edit_user_path

    rescue Exception => e
      flash.now[:alert] = e.message
      render :form
    end

  end

  private

  def update_password
    if params[:user][:password].present?

      unless @user.update_with_password(params[:user].symbolize_keys)
        raise ActiveRecord::RecordInvalid.new(@user)
      end

    end
  end

  def set_resource
    @user = current_user
  end

  def strong_params
    params.require('user').permit(:name)
  end

end
