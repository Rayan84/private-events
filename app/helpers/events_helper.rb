module EventsHelper
  def attendee?
    @event.attendees.exists?(session[:id])
  end

  def add_event_path
    "/events/add/#{@event.id}"
  end

  def attend_link
    link_to 'Attend this event', add_event_path, method: :put if !attendee? && user_signed_in?
  end

  def attendees_names
    names = ''
    @event.attendees.each do |attendee|
      names << (content_tag :p, (link_to attendee.username, attendee))
    end
    names.html_safe
  end

  def show_events(events)
    events_names = ''
    events.each do |event|
      text = event.title
      events_names << (content_tag :p, (link_to text, event))
    end
    events_names.html_safe
  end
end
