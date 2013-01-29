class Search < SitePrism::Page

  set_url "/sen/users/search"

  element :about_page_link, "li.user_name"
  element :logout_link, "li.logout"
  
  section :menu, MenuSection, "ul#menu"
  
  element :search_box, "#search_user .span2"
  element :search_button, "#search form#search_user input.btn"
  element :search_results, "#search_result"
  element :search_error, "#search_result.search-error"
  elements :users, ".user"
  element :username, ".user .title"
  element :unlinked_user, ".user .not_connected"
  element :users_link, ".user .details a"
  element :pending_request_user, ".request_pending"
  element :pending_response_user, ".response_pending"
  element :connection_alert, ".notice .message"
  element :show_more, ".sen_social #more a"
  element :error_notice, ".notice.warn .message"
  
end
