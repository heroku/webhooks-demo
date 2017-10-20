require "rails_helper"

RSpec.describe "Dashboard", type: :feature do
  it 'loads events from /events and actioncable' do
    login_capybara

    now = Time.now

    payload_1 = {'id' => SecureRandom.uuid}
    Event.create(payload: payload_1, created_at: now)

    payload_2 = {'id' => SecureRandom.uuid}
    Event.create(payload: payload_2, created_at: now - 1)

    visit '/'

    # wait for events from db to load and actioncable to connect
    expect(page).to have_selector('#loading-future', visible: true)

    cable_payload = {'id' => SecureRandom.uuid}
    ActionCable.server.broadcast('events', {'payload' => cable_payload})

    expect(page).to have_selector('#loading-future-done', visible: true)
    find(:css, '#loading-future-button').click

    rendered_payloads = page.all('.events-payload').map{|payload| JSON.parse(payload.text)}
    expect(rendered_payloads).to eq([cable_payload, payload_1, payload_2])
  end
end
