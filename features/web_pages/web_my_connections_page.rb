class MyConnections < SitePrism::Page
  set_url "/sen/connected_connections"
  
  element :header_message, ".sen_header"
  element :user, ".user"
  element :disconnect_button, ".connection_action .delete" 
  element :connection_message, ".connection_action div.message"
  element :username, ".user .title"
  element :connection_alert, ".notice .message"
  element :dialog, ".modal_container" 
  element :confirm_disconnect_button, ".modal_confirm_button"
  element :cancel_disconnect_button, ".modal_cancel_button"
  element :show_more, ".sen_social #more a"
  elements :users, ".user"
  section :menu, MenuSection, "ul#menu"   
  sections :my_connections_details, MyConnectionsSection, "#connection_details .user"    
   
end
