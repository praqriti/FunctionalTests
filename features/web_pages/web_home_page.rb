class Home < SitePrism::Page
  set_url "/"
  set_url_matcher //
  
  element :username_link, "li.user_name"
  element :header, "#header-logo"
  element :logout_link, "ul#identity li.logout a"
  element :status, "#status"
  element :status_message, "#status_message" 
  element :create_status_button, "form#new_status.new_status input.submit"
  element :updated_status_message, "input#status_message.autoclearInput.previousData"
  element :status_updated, "form#new_status.new_status input.disabled"
  section :menu, MenuSection, "ul#menu"
  element :status_notification_group, "li.stream-status .stream_header"
  element :status_notification_container, "li.stream-status .details_container"
  elements :status_notifications, "table#status-details tr"
  element :connection_notification_group, "li.stream-connection .stream_header"
  elements :connection_notification_group_links, "li.stream-connection .stream_header .links a"
  element :connection_notification_container, "li.stream-connection .details_container"
  elements :connection_notifications, "table#connection-details tr"
  elements :global_messages, "div.global-message.image-block .image-block-content .message"
  
  section :connection_alert, ConnectionAlert, ".image-block-content"
end
