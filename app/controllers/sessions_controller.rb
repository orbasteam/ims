class SessionsController < Devise::SessionsController

  layout 'devise'

  def slack_callback

    begin

      result = get_access_result
      raise result[:error] unless result[:ok]

      info = get_user_info(result[:access_token], result[:user_id])
      raise result[:error] unless info[:ok]

      email = info.dig(:user, :profile, :email)
      @user = User.find_by_email(email)

      unless @user
        raise I18n.t('devise.failure.not_found_in_database')
      end

      sign_in @user

      respond_with @user do |format|
        format.html { redirect_to after_sign_in_path_for(@user) }
        format.json { render json: @user }
      end

    rescue Exception => e
      redirect_to root_path, alert: e.message
    end

  end

  private

  def get_access_result

    unless params[:code]
      raise ActionController::RoutingError.new('Not Found')
    end

    data = {
      code: params[:code],
      client_id: Settings.slack.app_id,
      client_secret: Settings.slack.app_secret
    }
    retrieve_get('https://slack.com/api/oauth.access', data)

  end

  def get_user_info(access_token, user_id)
    data = {
      token: access_token,
      user: user_id
    }
    retrieve_get('https://slack.com/api/users.info', data)
  end

  def retrieve_get(url, data)
    uri = URI(url)
    uri.query = URI.encode_www_form(data)
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body, symbolize_names: true)
  end

end