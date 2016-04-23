module Devise::ApplicationHelper
  def more_links
    @result = []
    set_login_link
    set_signup_link
    set_forget_password_link
    set_confirmation_link
    set_unlock_link
    set_provider_links
    @result.join(link_glue).html_safe
  end

  private

  def link_glue
    ' | '
  end

  def set_login_link
    @result.push link_to(t('page.login'), new_user_session_path) if controller_name != 'sessions'
  end

  def set_signup_link
    if devise_mapping.registerable? && controller_name != 'registrations'
      @result.push link_to(t('page.sign_up'), new_user_registration_path) 
    end
  end

  def set_forget_password_link
    if devise_mapping.recoverable? && controller_name != 'passwords'
      @result.push link_to t('page.forget_password'), new_user_password_path(resource_name)
    end
  end

  def set_confirmation_link
    if devise_mapping.confirmable? && controller_name != 'confirmations'
      @result.push link_to(
        t('.didn_t_receive_confirmation_instructions', default: "Didn't receive confirmation instructions?"),
        new_user_confirmation_path(resource_name)
      )
    end
  end

  def set_unlock_link
    if devise_mapping.lockable? && resource_class.unlock_strategy_enabled(:email) && controller_name != 'unlocks'
      @result.push link_to(t('.didn_t_receive_unlock_instructions', default: "Didn't receive unlock instructions?"),
        new_user_unlock_path(resource_name)
      )
    end
  end

  def set_provider_links
    return unless devise_mapping.omniauthable?
    resource_class.omniauth_providers.each do |provider|
      @result.push link_to(
        t('.sign_in_with_provider', provider: provider.to_s.titleize, default: "Sign in with #{provider.to_s.titleize}"),
        omniauth_authorize_path(resource_name, provider)
      )
    end
  end
end