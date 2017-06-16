module AuthenticatingController
  private

  def authenticate_user!
    session = cookies.encrypted['_session_id']
    if session['token'] && session['email']
      unless Rails.env.development?
        host = request.env['HTTP_HOST']
        app = host.match(/(.*)\.herokuapp\.com$/)[1]

        heroku_api = PlatformAPI.connect_oauth(session['token'])
        heroku_api.app.info(app)
      end

      session['email']
    end
  end

  def authenticate_user
    begin
      authenticate_user!
    rescue Excon::Error::Forbidden
      false
    rescue Excon::Error::Unauthorized
      false
    rescue Excon::Error::NotFound
      false
    end
  end

  def authenticate_user_action!
    begin
      unless authenticate_user!
        respond_to do |format|
          format.html { redirect_to login_path }
          format.json { render json: {'error' => 'not_logged_in'}, status: :forbidden}
        end
      end
    rescue Excon::Error::Unauthorized
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { render json: {'error' => 'unauthorized'}, status: :forbidden}
      end
    rescue Excon::Error::Forbidden
      respond_to do |format|
        format.html { render html: "Forbidden", status: :forbidden }
        format.json { render json: {'error' => 'forbidden'}, status: :forbidden }
      end
    rescue Excon::Error::NotFound
      respond_to do |format|
        format.html { render html: "Not Found", status: :not_found}
        format.json { render json: {'error' => 'not_found'}, status: :not_found}
      end
    end
  end
end
