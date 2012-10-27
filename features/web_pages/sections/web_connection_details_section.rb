class ConnectionDetailsSection < SitePrism::Section
  
  element :accept_button, ".connection_action a.accept"
  element :reject_button, ".connection_action a.reject" 
  element :connection_message, ".connection_action div.message"
  element :username, ".title"
  element :user_image, "#search_result div.user img"
end
