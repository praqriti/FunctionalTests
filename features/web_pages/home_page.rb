class Home < SitePrism::Page
  set_url "/"
  
  element :about_page_link, "li.user_name"
  element :logout_link, "li.logout"
  element :status_box, "input#status_message"
  element :create_status_button, "form#new_status.new_status input.submit"  
  
  #make a section called connections so that it is available on all pages
  element :connections_dropdown, "li#connections_menu_item.menu-item"
  element :search_users, "ul.menu-item-drop-column-list li a#search-users"
  element :connection_requests, "ul.menu-item-drop-column-list li a#connection-requests"
  element :my_connections, "ul.menu-item-drop-column-list li a#my-connections"
  
  #make a my profile section
  element :my_profile, "li#my-profile_menu_item.menu-item"
end
