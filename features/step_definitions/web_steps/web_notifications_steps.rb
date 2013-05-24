Then /^The Status Activity Notification "(.*?)" visible$/ do |arg1|
  if arg1.include? "not"
    @app.home.should_not have_status_notification_group

  else
    notifications_page_reload do
      @app.home.has_status_notification_group?
    end
  end
end

Then /^only default status notification is visible$/ do
   retry_on_timeout do    
    @app.home.load 
    @app.home.has_status_notification_group?
  end
      @app.home.status_notification_group.text.include? '1 Status Activity'

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
  user = @users.last
  steps %{
     And "camfed_user" has his status set to "status_update_for_comment"
     And "camfed_user" has accepted connection request from "#{user.identifier}"
   	
    }
  for i in 1..comment_count.to_i
    steps %{
      Then "#{user.identifier}" comments "Comment_#{i}" on the status
    }
  end
end

Given /^User "(.*?)" has comment notifications from "(.*?)":$/ do |user_identifier,commenting_user,comments_table| 
  steps %{
    And "#{user_identifier}" has his status set to "status_update_for_comment"
    And "#{user_identifier}" has accepted connection request from "#{commenting_user}"
    
   }
comments_table.hashes.each do |hash|
    steps %{
      Then "#{commenting_user}" comments "#{hash["COMMENTS"]}" on the status
    }
   end
end

Given /^User "(.*?)" has the following comment notifications:$/ do |user_identifier,comments_table|
  steps %{
   And "#{user_identifier}" has his status set to "status_update_for_comment"  
  }
  comments_table.hashes.each do |hash|
  steps %{
    And "#{user_identifier}" has accepted connection request from "#{hash["COMMENTED_BY"]}"
    Then "#{hash["COMMENTED_BY"]}" comments "#{hash["COMMENT"]}" on the status
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
  notifications_page_reload do
     @app.home.has_connection_notification_group?
   end
  @app.home.connection_notification_group.click()
  @app.home.wait_for_connection_notification_container
end


Then /^User should see connected user notification of "(.*?)" and "(.*?)"$/ do |user1_identifier, user2_identifier|
  notifications_page_reload do
     @app.home.has_connection_notification_group?
   end
  user1 = @users.find{|user| user.identifier == user1_identifier}
  user2 = @users.find{|user| user.identifier == user2_identifier}
  @app.home.connection_notifications.select {|element| element.text.include? "#{user2.name} accepted #{user1.name}'s invitation to get connected."}.count.should == 1
end

Then /^User should see connection notifications on web:$/ do |connections_table|
  notifications_page_reload do
     @app.home.has_connection_notification_group?
   end
  connections_table.hashes.each do |hash|
  accepting_friend = @users.find{|user| user.identifier == hash["ACCEPTING_FRIEND"]}
  requesting_friend = @users.find{|user| user.identifier == hash["REQUESTING_FRIEND"]}
    @app.home.connection_notifications.select {|element|
    element.text.include? "#{accepting_friend.name} accepted #{requesting_friend.name}'s invitation to get connected."}
    .count.should == 1
end
end

Then /^notification should take user to the "(.*?)" wall of "(.*?)"$/ do |view,user_identifier|
  notifications_page_reload do
     @app.home.has_connection_notification_group?
   end
  user = @users.find{|user| user.identifier == user_identifier}
  steps %{
    Given "#{user_identifier}" has his status set to "checking for public/private wall view"
  }
  @app.home.connection_notification_group_links.select{|element| element.text.include? "#{user.name}"}.count.should == 1
  @app.home.connection_notification_group_links.select do |element| 
    if (element.text == "#{user.name}")
      element.click
    end
  end  
  steps %{
    Then User can view the "#{view}" wall of the user "#{user.name}"
   }
end


Then /^User should see "(.*?)" connection notifications on home page$/ do |count|
  steps %{
    When User clicks on connection notification group
  }
    @app.home.connection_notifications.count.should == (count.to_i)+1
    # added +1 for the first summary block on notifications
end