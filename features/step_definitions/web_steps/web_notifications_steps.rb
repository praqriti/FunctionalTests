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
   Then home page has the following comment notifications:
   |COMMENTED_BY|COMMENT|
   |#{user_id}|#{message}|
  }
end

Then /^home page has the following comment notifications:$/ do |comments_table|
  steps %{
   Then The Status Activity Notification "is" visible
  }
  @app.home.status_notification_group.click()
  retry_on_timeout do
    @app.home.wait_for_status_notification_container
    @app.home.should have_status_notification_container
  end
  comments_table.hashes.each do |hash|
  user = @users.find{|user| user.identifier == hash[:COMMENTED_BY]}  
  notification_count = @app.home.status_notifications.select { |element| 
    element.text.include?("#{user.name}") &&
    element.text.include?("#{hash["COMMENT"]}")
  }.count
  if (notification_count == 0)
    raise "Unable to find comment notification :#{hash["COMMENT"]}"
  end
end
end

Then /^home page does not have the following comment notifications:$/ do |comments_table|
  steps %{
   Then The Status Activity Notification "is" visible
  }
  @app.home.status_notification_group.click()
  retry_on_timeout do
    @app.home.wait_for_status_notification_container
    @app.home.should have_status_notification_container
  end
  comments_table.hashes.each do |hash|
  user = @users.find{|user| user.identifier == hash[:COMMENTED_BY]}  
  @app.home.status_notifications.select { |element| 
    element.text.include?("#{user.name}") &&
    element.text.include?("#{hash["COMMENT"]}")
  }.count.should == 0
end
end

Given /^User has "(.*?)" comment notifications$/ do |comment_count|
  user =  @users.last 
  steps %{
    And "camfed_user" has his status set to "status_update_for_comment"
    When User is on the Sign In page
    And User "#{user.identifier}" logs into Canvas with her credentials
    And User can navigate and view the "private" wall of user "camfed_user"
  }
  for i in 1..comment_count.to_i
    steps %{
       Then User comments "Comment_#{i}" on the status of "#{user.identifier}"
    }
    sleep(1)
   end
   steps %{
    Then User logs out   
  }
end


Given /^User has "(.*?)" comment notifications from "(.*?)"$/ do |comment_count,user_identifier|
  steps %{
    Given "camfed_user" is connected to "#{user_identifier}"
    And "camfed_user" has his status set to "status_update_for_comment"
    When User is on the Sign In page
    And User "#{user_identifier}" logs into Canvas with her credentials
    And User can navigate and view the "private" wall of user "camfed_user"
  }
  for i in 1..comment_count.to_i
    steps %{
       Then User comments "Comment_#{i}" on the status of "#{user_identifier}"
    }
    sleep(1)
   end
   steps %{
    Then User logs out   
  }
end

Given /^User has comment notifications from "(.*?)":$/ do |user_identifier,comments_table|
  steps %{
    Given "camfed_user" is connected to "#{user_identifier}"
    And "camfed_user" has his status set to "status_update_for_comment"
    When User is on the Sign In page
    And User "#{user_identifier}" logs into Canvas with her credentials
    And User can navigate and view the "private" wall of user "camfed_user"
  }
comments_table.hashes.each do |hash|
    steps %{
       Then User comments "#{hash["COMMENTS"]}" on the status of "#{user_identifier}"
    }
    sleep(1)
   end
   steps %{
    Then User logs out   
  }
end

Given /^User has the following comment notifications:$/ do |comments_table|
  steps %{
   And "camfed_user" has his status set to "status_update_for_comment"
  }
  comments_table.hashes.each do |hash|
  steps %{
    Given "camfed_user" is connected to "#{hash["COMMENTED_BY"]}"   
    When User is on the Sign In page
    And User "#{hash["COMMENTED_BY"]}" logs into Canvas with her credentials
    And User can navigate and view the "private" wall of user "camfed_user"
    Then User comments "#{hash["COMMENT"]}" on the status of "#{hash["COMMENTED_BY"]}"
    }
    sleep(1)
    steps %{
    Then User logs out   
  }
end
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