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

  def authenticate_user!
    puts "Authorization header.xx #{request.authorization}"
    puts "request.env.xx #{request.env["Authorization"]}"
    puts "request.session.xx #{request.session["Authorization"]}"
    puts "cookies..xx #{cookies}"
    session = cookies.encrypted[:_session_id]
    puts "session..xx #{session}"
    if session && session['token'] && session['email']
      heroku_api = PlatformAPI.connect_oauth(session['token'])
      puts "heroku api client #{heroku_api}"
      puts "heroku app #{heroku_app}"
      puts "app info without suffix #{heroku_api.app.info('webhooks-demo-marcel-4')}"
      heroku_api.app.info(heroku_app)
      puts "app info with suffix #{heroku_api.app.info(heroku_app)}"


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
