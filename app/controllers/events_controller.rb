class EventsController < ApplicationController

  def new
    @created_event = Event.new
  end

  def create
    @created_event = Event.new(event_params)

    if @created_event.save
      redirect_to @created_event
    else
      render :new
    end
  end

  def show
    @created_event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :date)
  end

end
