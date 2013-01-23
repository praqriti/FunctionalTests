Then /^The Status Activity Notification "(.*?)" visible$/ do |arg1|
  if arg1.include? "not"
    @app.home.should_not have_status_notification_group
  else
    notifications_page_reload do
      @app.home.has_status_notification_group?
    end
  end
end

Then /^Status Updated notification is visible for "(.*?)" with status:"(.*?)"$/ do |user_id, message|
  steps %{
   Then Comment added notification is visible for "#{user_id}" with comment:"#{message}"
  }
end

Then /^Comment added notification is visible for "(.*?)" with comment:"(.*?)"$/ do |user_id, message|
  steps %{
   Then The Status Activity Notification "is" visible
  }
  user = @users.find{|user| user.identifier == user_id}
  @app.home.status_notification_group.click()
  @app.home.wait_for_status_notification_container
  @app.home.status_notifications.select {|element| element.text.include?("#{user.name}") && element.text.include?("#{message}")}.count.should == 1
end


Then /^User should see connection notifications containing link of "(.*?)" profile$/ do |user_identifier|
  notifications_page_reload do
    @app.home.has_connection_notification_group?
  end
  user = @users.find{|user| user.identifier == user_identifier}

  @app.home.connection_notification_group_links.select{|element| element.text.include? "#{user.name}"}.count.should == 1
end

When /^User clicks on connection notification group$/ do
  @app.home.connection_notification_group.click()
  @app.home.wait_for_connection_notification_container
end


Then /^User should see connected user notification of "(.*?)" and "(.*?)"$/ do |user1_identifier, user2_identifier|
  user1 = @users.find{|user| user.identifier == user1_identifier}
  user2 = @users.find{|user| user.identifier == user2_identifier}
  @app.home.connection_notifications.select {|element| element.text.include? "#{user2.name} accepted #{user1.name}'s invitation to get connected."}.count.should == 1
end