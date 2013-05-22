Then /^user edits his settings/ do
 @app.canvas_user_settings.edit_settings.click
end

Then /^user updates his location to "(.*?)" and "(.*?)"$/ do |country, district|
 @app.canvas_user_settings.country.select("#{country}")
 @app.canvas_user_settings.district.select("#{district}")
end

Then /^user updates the settings$/ do
  @app.canvas_user_settings.update_settings.click
  sleep 1
end

When /^User visits the settings page$/ do
  @app.canvas_user_settings.load
end

Then /^User should see "(.*?)" and "(.*?)" as the location in its profile$/ do |country, district|
    p "@app.canvas_user_settings.location.text: ", @app.canvas_user_settings.location.text
    @app.canvas_user_settings.location.text.should == "#{district}, #{country}"
end
