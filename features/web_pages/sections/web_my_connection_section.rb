class MyConnectionsSection < SitePrism::Section
  element :disconnect_button, ".delete" 
  element :username, ".title"
  element :user_image, ".img"
end
