class UserPage < SitePrism::Page
  def self.set_page_url account_id, user_id
    self.set_url "/accounts/#{account_id}/users/#{user_id}"
  end

  element :name,     'fieldset#name_and_email td.name'
  element :location, 'fieldset#name_and_email td.location'
end
