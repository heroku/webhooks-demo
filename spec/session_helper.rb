module SessionHelper
  def login(status: 200)
    allow_any_instance_of(ApplicationController).to receive(:heroku_app).and_return('foobar')

    OmniAuth.config.mock_auth[:heroku] = OmniAuth::AuthHash.new({
      :provider => 'heroku',
      :credentials => {
        :token => '4321'
      },
      :info => {
        :email => 'foo@bar.com'
      }
    })

    get '/auth/heroku/callback'

    Excon.stub({
      host: 'api.heroku.com',
      path: '/apps/foobar',
      method: :get
    }, {status: status})
  end

  def login_capybara(status: 200)
    allow_any_instance_of(ApplicationController).to receive(:heroku_app).and_return('foobar')
    allow_any_instance_of(ApplicationCable::Connection).to receive(:heroku_app).and_return('foobar')

    OmniAuth.config.mock_auth[:heroku] = OmniAuth::AuthHash.new({
      :provider => 'heroku',
      :credentials => {
        :token => '4321'
      },
      :info => {
        :email => 'foo@bar.com'
      }
    })

    Excon.stub({
      host: 'api.heroku.com',
      path: '/apps/foobar',
      method: :get
    }, {status: status})

    visit '/auth/heroku/callback'
  end

end
