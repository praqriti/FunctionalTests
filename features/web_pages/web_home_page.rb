class Home < SitePrism::Page
  set_url "/"
  
  element :about_page_link, "li.user_name"
  element :header, "#header-logo"
  element :logout_link, "ul#identity li.logout a"
  element :status_message, "input[name='status[message]']" 
  element :create_status_button, "form#new_status.new_status input.submit"
  element :updated_status_message, "input#status_message.autoclearInput.previousData"
  element :status_updated, "form#new_status.new_status input.disabled"
  section :menu, MenuSection, "ul#menu"
    
end
