Then /^The Status Updated Notification "(.*?)" visible$/ do |arg1|
  if arg1.include? "not"
    @app.home.should_not have_status_updated_notification_name
  else
    @app.home.should have_status_updated_notification_name
  end
end

Then /^Status Updated notification is visible for "(.*?)" with status:"(.*?)"$/ do |user_id, message|
  user = @users.find{|user| user.identifier == user_id}
  @app.home.notification_messages[0].text.should == "#{user.name}'s new status message is \"#{message}\""
end

Then /^Comment added notification is visible for "(.*?)" with comment:"(.*?)"$/ do |user_id, message|
  user = @users.find{|user| user.identifier == user_id}
  notifications_page_reload do
    @app.home.notification_messages.select {|element| element.text == "#{user.name}'s comment \"#{message}\""}.count == 1
  end
end


Then /^User should see connected user notification of "(.*?)" and "(.*?)"$/ do |user1_identifier, user2_identifier|
  user1 = @users.find{|user| user.identifier == user1_identifier}
  user2 = @users.find{|user| user.identifier == user2_identifier}

  notifications_page_reload do
    @app.home.notification_messages.select {|element| element.text == "#{user2.name} accepted #{user1.name}'s invitation to get connected."}.count == 1
  end
end