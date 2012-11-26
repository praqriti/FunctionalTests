class Search < SitePrism::Page

  set_url "/sen/users/search"

  element :about_page_link, "li.user_name"
  element :logout_link, "li.logout"
  
  section :menu, MenuSection, "ul#menu"
  
  element :search_box, "form#search_user input.span2"
  element :search_button, "div#search form#search_user input.btn"
  element :search_results, "div#search_result"
  element :search_error, "div#search_result.search-error"
  elements :users, ".user"
  element :username, ".user .title"
  element :unlinked_user, ".user .not_connected"
  element :users_link, ".user div.details a"
  element :pending_request_user, ".request_pending"
  element :pending_response_user, ".response_pending"
  element :connection_alert, "div.notice div.message"
  element :show_more, ".sen_social #more a"
  element :error_notice, "div.notice.warn div.message"
  
end
