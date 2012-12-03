Given /^User chooses the option "Groups"$/ do
 steps %{
   Then User replies with option "4"
 }
end

Given /^User "(.*?)" is enrolled with following groups:$/ do |username, groups_table|
  user = @users.find{|user| user.identifier == username}

  groups_table.hashes.each do |hash|
    group = Group.create(hash)
    @groups << group

    group.join user
  	@enrolled_groups << group
	end
end

When /^User chooses the group "(.*?)"$/ do |group_name|
	message = @last_response.parsed_response["message"]
  group_no, _ = message.match(/(\d+)\. #{group_name}/i)
  steps %{
     Then User replies with option "#{group_no[1]}"
   }
end


Given /^the following groups exist in canvas:$/ do |groups_table|
	groups_table.hashes.each do |hash|
		@groups << Group.create(hash)
	end
end


Given /^User is enrolled to the following groups:$/ do |enrollment_table|
  enrollment_table.hashes.each do |hash|
  enroll_type = "#{hash[:ROLE]}Enrollment"
	user = @users.find{|user| user.identifier == username}
		@groups.each do |group|
			if(group.name == "#{hash[:COURSE]}")
				CanvasEnrollmentInterface.enroll_user(group.id, user.id, enroll_type, "active")
			@enrolled_groups << group
			end
		end
	end
end


Then /^User should see the groups list$/ do
	actual_response = @last_response.parsed_response
	s_no = 1
	@enrolled_groups.each do |enrolled_group|
    actual_response["message"].include?(enrolled_group.name).should == true
	s_no+=1
	end
	steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
		}
end

Then /^User should see the groups list on page "([^\"]*)"$/ do |page_no|
	actual_response = @last_response.parsed_response
	page_no = page_no.to_i
	rpp = "#{RECORDS_PER_PAGE}".to_i
	s_no = (rpp * (page_no-1)) + 1
	start_index = rpp * (page_no-1)
  end_index = start_index + (rpp-1)
	@enrolled_groups.reverse[start_index..end_index].each do |enrolled_group|
		actual_response["message"].include?(enrolled_group.name).should == true
	end
	steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
		}
end

Then /^User should only see group "([^\"]*)"$/ do |group_name|
  actual_response["message"].include?("1. #{group_name}").should == true
	steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
		}
end

Then /^User should see the group menu page$/ do
  actual_response = @last_response.parsed_response
  actual_response["message"].should == @messages.get("group_menu")
end
