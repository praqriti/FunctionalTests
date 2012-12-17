Then /^The Status Updated Notification "(.*?)" visible$/ do |arg1|
  if arg1.include? "not"
    @app.home.should_not have_status_updated_notification_name
  else
    @app.home.should have_status_updated_notification_name
  end
end

Then /^Status Updated notification is visible for "(.*?)" with status:"(.*?)"$/ do |user_id, message|
  user = @users.find{|user| user.identifier == user_id}
  @app.home.notification_message.text.should == "#{user.name}'s new status message is \"#{message}\""
end