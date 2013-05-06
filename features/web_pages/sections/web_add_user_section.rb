class AddUser < SitePrism::Section
  
  element :full_name, 'input#user_name'
  element :email, 'input#pseudonym_path'
  element :login, 'input#pseudonym_unique_id'
  element :country, 'select#user_country_id'
  element :district, 'select#user_district_id'
  element :send_email?, 'input#pseudonym_send_confirmation'
  element :submit_button, 'div.ui-dialog-buttonset button.submit_button'
end
