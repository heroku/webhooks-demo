require "rails_helper"

RSpec.describe "Events", type: :request do
  it 'is unauthorized when not logged in' do
    get events_path, as: :json
    expect(response).to have_http_status(:unauthorized)
    expect(response.parsed_body).to eq({'error' => 'not_logged_in'})
  end

  it 'is unauthorized when token has expired' do
    login status: 401

    get events_path, as: :json
    expect(response).to have_http_status(:unauthorized)
    expect(response.parsed_body).to eq({'error' => 'unauthorized'})
  end

  it 'forbids when not authorized to app' do
    login status: 403

    get events_path, as: :json
    expect(response).to have_http_status(:forbidden)
    expect(response.parsed_body).to eq({'error' => 'forbidden'})
  end

  it 'not founds when app not found' do
    login status: 404

    get events_path, as: :json
    expect(response).to have_http_status(:not_found)
    expect(response.parsed_body).to eq({'error' => 'not_found'})
  end

  it 'renders events ordered by created_at' do
    login

    Event.create(payload: {biz: 'baz'}, created_at: Date.parse('2001-02-04'))
    Event.create(payload: {foo: 'bar'}, created_at: Date.parse('2001-02-03'))

    get events_path, as: :json
    expect(response).to have_http_status(:ok)
    expect(response.parsed_body).to eq([
      {
        'payload' => {'biz' => 'baz'},
        'created_at' => '2001-02-04T00:00:00.000Z'
      },
      {
        'payload' => {'foo' => 'bar'},
        'created_at' => '2001-02-03T00:00:00.000Z'
      }
    ])
  end
end
