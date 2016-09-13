class ApiV1::EventsController < ApiController
  before_action :authenticate_user!

  def index
    @events = Event.includes(:user, :attendees).page(params[:page])
  end

  def show
    # TODO 依 /spec/requests/events_spec.rb 完成 action show
  end

  def create
    @event = Event.new(:name => params[:name],
                       :description => params[:description],
                       :user => current_user)
    if @event.save
      render :json => @event.to_json
    else
      render :json => { :message => "failed" }, :status => 400
    end
  end

  def update

  end
end
