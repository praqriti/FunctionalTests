class MenuSection < SitePrism::Section
  
  element :my_wall, "li#wall_menu_item.menu-item a.menu-item-no-drop"
  element :courses, "li#courses_menu_item.menu-item a.menu-item-no-drop"
  element :grades, "li#grades_menu_item.menu-item a.menu-item-no-drop"
  element :assignments, "li#assignments_menu_item.menu-item a.menu-item-no-drop"
  element :calendar, "li#calendar_menu_item.menu-item a.menu-item-no-drop"
  
  section :connections, ConnectionsSection, "li#connections_menu_item.menu-item a"
  
end