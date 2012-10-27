class MyConnectionsSection < SitePrism::Page
  
  element :disconnect_button, ".connection_action .delete" 
  element :username, ".user .title"
  element :user_image, ".user img"
end
