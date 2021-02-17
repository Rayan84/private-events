require 'rails_helper'

RSpec.describe 'Event', type: :model do
  it 'is valid when every element is present' do
    user = User.create(username: 'Bob')
    event = Event.create(date: Date.today.to_s, title: 'title', location: 'location', description: 'description',
                         creator_id: user.id)
    expect(event).to be_valid
  end
  it 'is not valid if one of the elements are not present' do
    user = User.create(username: 'Bob')
    event = Event.create(date: Date.today.to_s, title: '', location: 'location', description: 'description',
                         creator_id: user.id)
    expect(event).not_to be_valid
  end
  it 'is not valid when the creator id is empty' do
    event = Event.create(date: Date.today.to_s, title: 'title', location: 'location', description: 'description',
                         creator_id: '')
    expect(event).not_to be_valid
  end
  describe 'assosiations' do
    it 'can have many attendees' do
      event = Event.reflect_on_association(:attendees)
      expect(event.macro).to eql(:has_many)
    end
    it 'belongs to one creator' do
      event = Event.reflect_on_association(:creator)
      expect(event.macro).to eql(:belongs_to)
    end
  end
end

RSpec.feature 'Events' do
  before(:each) do
    @user = User.create(username: 'user1')
  end
  before(:each) do
    @event = @user.created_events.build(title: 'event 1', location: 'location', description: 'description',
                                        date: '2000-01-01')
    @event.save
  end
  scenario 'when a user creates an event' do
    visit '/users/sign_in'
    fill_in 'username', with: 'user1'
    click_on 'Submit'
    click_on 'Create Event'
    fill_in 'event_title', with: 'new_event'
    fill_in 'event_location', with: 'location'
    fill_in 'event_date', with: '2021-01-15'
    fill_in 'event_description', with: 'description'
    click_on 'Submit'
    expect(page).to have_content 'new_event'
  end
  scenario 'when a user creates an event but leaves something blank' do
    visit users_sign_in_path
    fill_in 'username', with: 'user1'
    click_on 'Submit'
    click_on 'Create Event'
    fill_in 'event_title', with: 'new_event'
    fill_in 'event_location', with: nil
    fill_in 'event_date', with: '2021-01-15'
    fill_in 'event_description', with: 'description'
    click_on 'Submit'
    expect(page).to have_content "Location can't be blank"
  end
  scenario 'when a user clicks on an event link' do
    visit root_path
    click_on 'event 1'
    expect(current_path).to eql('/events/1')
  end
  scenario 'when a logged in user attends an event' do
    visit users_sign_in_path
    fill_in 'username', with: 'user1'
    click_on 'Submit'
    click_on 'Events'
    click_on 'event 1'
    click_on 'Attend this event'
    expect(@event.attendees.exists?(1)).to eql(true)
  end
  scenario "when a user visits an event but doesn't attend" do
    visit users_sign_in_path
    fill_in 'username', with: 'user1'
    click_on 'Submit'
    click_on 'Events'
    click_on 'event 1'
    expect(@event.attendees.exists?(1)).to eql(false)
  end
end
