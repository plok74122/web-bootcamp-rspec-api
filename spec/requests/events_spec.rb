require 'rails_helper'

RSpec.describe "Events", type: :request do
  let!(:user1) { User.create!(:email => "foo@bar.com", :password => "12345678") }
  let!(:user2) { User.create!(:email => "bar@foo.com", :password => "12345678") }
  let!(:user3) { User.create!(:email => "foobar@foo.com", :password => "12345678") }
  let!(:event1) { Event.create!(:name => "this is event 1", :description => "this is description 1", :user_id => user1.id) }
  let!(:event2) { Event.create!(:name => "this is event 2", :description => "this is description 2", :user_id => user1.id) }

  describe "GET /api/v1/events" do
    it "should return events" do
      get v1_events_path, :auth_token => user1.authentication_token
      @events = Event.includes(:user, :attendees).page

      data = {
        "meta" => {
          "current_page" => @events.current_page,
          "total_pages" => @events.total_pages,
          "per_page" => @events.limit_value,
          "next_url" => (@events.last_page?) ? nil : v1_events_url(:page => @events.next_page),
          "previous_url" => (@events.first_page?) ? nil : v1_events_url(:page => @events.prev_page)
        },
        "results" => [{
                        "name" => event1.name,
                        "description" => event1.description,
                        "participate_count" => event1.attendees.count,
                        "founder" => { "email" => event1.user.email }
                      }, {
                        "name" => event2.name,
                        "description" => event2.description,
                        "participate_count" => event2.attendees.count,
                        "founder" => { "email" => event2.user.email }
                      },
        ]
      }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(data)
    end
  end

  describe "GET /api/v1/event/:id" do
    it "should return event and attendee when user is founder" do
      Attendee.create(:event_id => event1.id, :user_id => user2.id)
      Attendee.create(:event_id => event1.id, :user_id => user3.id)
      # get ___________________________________________
      data = {
        "event" => {
          "name" => event1.name,
          "description" => event1.description,
          "participate_count" => event1.attendees.count,
          "founder" => { "email" => event1.user.email }
        },
        "participate" => [
          {
            "email" => user2.email
          },
          {
            "email" => user3.email
          }
        ]
      }
      # expect(response).to have_http_status(___)
      # expect(JSON.parse(response.body)).to eq(data)
    end
    it "should return event when user is not founder" do
      # get ___________________________________________
      data = {
        "event" => {
          "name" => event1.name,
          "description" => event1.description,
          "participate_count" => event1.attendees.count,
          "founder" => { "email" => event1.user.email }
        }
      }
      # expect(response).to have_http_status(___)
      # expect(JSON.parse(response.body)).to eq(data)
    end
  end
end
