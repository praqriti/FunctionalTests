class Search < SitePrism::Page

  set_url "/sen/users/search"

  element :about_page_link, "li.user_name"
  element :logout_link, "li.logout"
  
  section :menu, MenuSection, "ul#menu"
  
  element :search_box
  element :search_button
  element :search_results
end
