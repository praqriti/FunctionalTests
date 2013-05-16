Then /^admin edits the user$/ do
 @app.canvas_user_profile.edit_user.click
end

Then /^sets location as "(.*?)" and "(.*?)"$/ do |country, district|
 @app.canvas_user_profile.country1.select("#{country}")
 @app.canvas_user_profile.district1.select("#{district}")
end

Then /^admin updates the user$/ do
  @app.canvas_user_profile.update_details.click
  sleep 1
end
