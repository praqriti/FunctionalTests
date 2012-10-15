class Search < SitePrism::Page

  set_url "/sen/users/search"

  element :about_page_link, "li.user_name"
  element :logout_link, "li.logout"
  
  section :menu, MenuSection, "ul#menu"
  
  element :search_box, "form#search_user input.span2"
  element :search_button, "div#search form#search_user input.btn"
  element :search_results, "div#search_result.search-error"
  elements :users, ".user"
end
