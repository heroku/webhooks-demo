RSpec.describe 'CVE-2015-9284', type: :request do
  describe 'GET /auth/:provider' do
    it do
      expect {
        get '/auth/heroku'
      }.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'POST /auth/:provider without CSRF token' do
    before do
      @allow_forgery_protection = ActionController::Base.allow_forgery_protection
      OmniAuth.config.request_validation_phase = OmniAuth::RailsCsrfProtection::TokenVerifier.new
      ActionController::Base.allow_forgery_protection = true
    end

    it do
      expect {
        post '/auth/heroku'
      }.to raise_error(ActionController::InvalidAuthenticityToken)
    end

    after do
      ActionController::Base.allow_forgery_protection = @allow_forgery_protection
      OmniAuth.config.request_validation_phase = OmniAuth::AuthenticityTokenProtection
    end
  end
end
