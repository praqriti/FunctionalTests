class UserSettingsPage < SitePrism::Page
  set_url "/profile/settings"

  element :name,     'table.profile_table span.full_name'
  element :edit_settings, 'a.edit_settings_link'
  element :location, 'span.location'
  element :country, 'select#user_country_id'
  element :district, 'select#user_district_id'
  element :update_settings, 'div.form-actions button.btn-primary'

end
