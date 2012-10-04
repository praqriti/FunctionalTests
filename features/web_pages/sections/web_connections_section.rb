class ConnectionsSection < SitePrism::Section
  element :search_users_link, "ul.menu-item-drop-column-list li a#search_connections"
  element :connection_requests, "ul.menu-item-drop-column-list li a#connection-requests"
  element :my_connections, "ul.menu-item-drop-column-list li a#my-connections"
end