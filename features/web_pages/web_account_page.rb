class Account < SitePrism::Page
  def self.set_page_url account_id
    self.set_url "/accounts/#{account_id}"
  end

  element :add_user_button, 'a.add_user_link'
  element :success_message, "ul#flash_message_holder li.ui-state-success"
  element :user_link, "li.ui-state-success a"
  section :add_user, AddUser, 'div.ui-dialog'
end
