class MyConnections < SitePrism::Page
  set_url "/sen/connected_connections"
  
  element :header_message, ".sen_header"
  element :user, ".user"
  element :disconnect_button, ".connection_action .delete" 
  element :connection_message, ".connection_action div.message"
  element :username, ".user .title"
  element :connection_alert, ".notice .message" 
  section :menu, MenuSection, "ul#menu"    
end
