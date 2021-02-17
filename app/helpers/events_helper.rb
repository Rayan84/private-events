module EventsHelper
  def attendee?
    @event.attendees.exists?(session[:id])
  end

  def add_event_path
    "/events/add/#{@event.id}"
  end
end
