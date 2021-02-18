module UsersHelper
  def show_links
    links = ''
    if user_signed_in?
      text = 'Logged in as: '
      links << (content_tag :p, text)
      links << (content_tag :p, (link_to current_user.username, current_user))
      links << (content_tag :p, (link_to 'Logout', users_log_out_path, method: :delete))
      links << (content_tag :p, (link_to 'Create Event', new_event_path))
    else
      links << (content_tag :p, (link_to 'Login', users_sign_in_path))
    end
    links.html_safe
  end
end
