require "rails_helper"

RSpec.describe "Dashboard", type: :feature do
  it 'loads events from /events and actioncable' do
    login_capybara

    db_uuid = 'c6a7e2ff-643c-490f-83dd-6333f1e47a49'
    Event.create(payload: {id: db_uuid})

    visit '/'

    # wait for events from db to load and actioncable to connect
    expect(page).to have_content("Events will appear as they are received by the application...")

    cable_uuid = 'b0bddf33-9cd1-4556-9c29-9cdd9aa3125c'
    ActionCable.server.broadcast('events', {'payload' => {'id' => cable_uuid}})

    expect(page).to have_content(db_uuid)
    expect(page).to have_content(cable_uuid)
  end
end
