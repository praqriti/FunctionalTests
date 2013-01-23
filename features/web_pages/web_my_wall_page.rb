class Wall < SitePrism::Page
  set_url "/sen/wall"
  
  element :about_page_link, "li.user_name"
  element :logout_link, "li.logout"
  
  section :menu, MenuSection, "ul#menu"
    
  element :user_name, ".profile_headings"
  element :full_name, "table.profile_table tbody tr td.name"
  element :display_name, "table.profile_table tbody tr td.short_name"
  element :profile_picture, "div.profile_headings img"
  element :status_message, "div#status_message em"
	element :timestamp_status, "div#status_message span.created_at"
  element :comment_box, "textarea#comment_message.autoclearInput"
  element :comment_submit, "form#new_comment.new_comment input.submit"
  elements :comments, ".comment_text"
  element :commented_by, "span.commented_by"
  element :commented_at, "div.commented_by span.created_at"
  element :error_message, "form#new_comment.new_comment div.error_msg"
  element :previous_status_link, "a#status_history_link"
  elements :previous_status_message_details, "#history_status_message em.status_details"
  elements :previous_status_comments, "#history_status_message .comments fieldset.comment fieldset span.comment_text"
	element :no_status_message, "div#user_profile_panel.sen_social div#status_history"
	element :status_with_comments, ".status_with_comments"
	element :common_connections_panel, "#common_connections.panel"
	element :add_connection_button_div, ".connection-link"
	element :add_connection_button, "#connection_request_from_wall .submit"
	element :birthdate, ".birthdate"
	element :language, ".language"
	element :time_zone, ".time_zone"

	sections :common_connections, CommonConnections, "#common_connections.panel ul.list li"

  def visit_profile_page user_id
    self.class.set_url "/sen/users/#{user_id}"
    self.load
  end
end
