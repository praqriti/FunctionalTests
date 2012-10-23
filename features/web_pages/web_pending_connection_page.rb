class ConnectionRequests < SitePrism::Page
  set_url "/sen/pending_connections"
  
  element :header_message, ".sen_header"
  element :user, ".user"
  element :accept_button, ".connection_action a.accept"
  element :reject_button, ".connection_action a.reject" 
  element :connection_message, ".connection_action div.message"
  element :username, ".user .title"
  element :connection_alert, ".notice .message" 
  section :menu, MenuSection, "ul#menu"    
end
