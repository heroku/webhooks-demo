require "rails_helper"

RSpec.describe "Dashboard", type: :request do
  it 'redirects to login when no session' do
    get root_path, as: :html
    expect(response).to redirect_to login_path
  end

  it 'redirects to login when token expires' do
    login status: 401

    get root_path, as: :html
    expect(response).to redirect_to login_path
  end

  it 'forbids when not authorized to app' do
    login status: 403

    get root_path, as: :html
    expect(response).to have_http_status(:forbidden)
  end

  it 'not founds when app is not found' do
    login status: 404

    get root_path, as: :html
    expect(response).to have_http_status(:not_found)
  end

  it 'renders events when allowed' do
    login

    get root_path, as: :html
    expect(response).to have_http_status(:ok)
  end
end
