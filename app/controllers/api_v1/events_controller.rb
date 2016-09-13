class ApiV1::EventsController < ApiController
  before_action :authenticate_user!

  def index
    @events = Event.includes(:user , :attendees).page(params[:page])
  end

  def show
    # TODO 依 /spec/requests/events_spec.rb 完成 action show
  end
end
