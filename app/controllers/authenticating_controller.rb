module AuthenticatingController
  private

  def heroku_app
    if Rails.env.development?
      dev_app = ENV['DEVELOPMENT_APP']
      unless dev_app
        raise 'Set DEVELOPMENT_APP to app to check auth against in dev'
      end
      dev_app
    else
      match = request.host.match(/(.*)\.herokuapp\.com$/)

      unless match
        raise 'Could not determine heroku app from host'
      end

      match[1]
    end
  end

  # heroku adds a -xxxx suffix to the app name when creating the web_url for an app
  # this method strips out that suffix to use the correct app name when querying the api
  # as an example https://my-great-app-f47016ef1d19.herokuapp.com/ would be parsed to
  # my-great-app-f47016ef1d19 in the heroku_app method and my-great-app here
  def strip_suffix_from_app_name(app_name)
    match = app_name.match(/(.*)\-.+/)
    if not match
      return app_name
    end
    match[1]
  end

  def get_app_info(heroku_api, app_name)
      begin
        heroku_api.app.info(app_name)
      rescue Excon::Error::NotFound
        app_name = strip_suffix_from_app_name(app_name)
        heroku_api.app.info(app_name)
      end
  end

  def authenticate_user!
    auth_header = request.authorization
    app_name = heroku_app
    # try first to authenticate the request from Bearer token authorization header and
    # if that doesn't work try the previous session_id from the cookies
    if auth_header
      token = auth_header.match(/Bearer (.*)$/)[1]
      heroku_api = PlatformAPI.connect_oauth(token)
      get_app_info(heroku_api, app_name)
    elsif session && session['token'] && session['email']
      session = cookies.encrypted[:_session_id]
      heroku_api = PlatformAPI.connect_oauth(session['token'])
      get_app_info(heroku_api, app_name)
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
          format.json { render json: {'error' => 'not_logged_in'}, status: :unauthorized}
        end
      end
    rescue Excon::Error::Unauthorized
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { render json: {'error' => 'unauthorized'}, status: :unauthorized}
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
