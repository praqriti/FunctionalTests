class ConnectionRequests < SitePrism::Page
  set_url "/sen/pending_connections"
  
  element :header_message, ".sen_header"
  element :user, ".user"
  element :accept_button, ".connection_action .accept input.social-button"
  element :reject_button, ".connection_action .reject input.social-button"
  element :connection_message, ".connection_action div.message"
  element :username, ".user .title"
  element :connection_alert, ".notice .message" 
  element :show_more, ".sen_social #more a"
  elements :users, ".user"
  sections :connection_details, ConnectionDetailsSection, "#connection_details .user"    
end
