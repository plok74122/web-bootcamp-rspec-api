class ApiV1::EventsController < ApiController
  before_action :authenticate_user!

  def index
    @events = Event.includes(:user , :attendees).page(params[:page])
  end
end
