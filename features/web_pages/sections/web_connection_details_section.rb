class ConnectionDetailsSection < SitePrism::Section
  
  element :accept_button, ".connection_action .accept input.social-button"
  element :reject_button, ".connection_action .reject input.social-button"
  element :connection_message, ".connection_action div.message"
  element :username, ".title"
  element :user_image, "#search_result div.user img"
end
