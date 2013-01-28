Given /^User chooses the option "Groups"$/ do
 steps %{
   Then User replies with option "4"
 }
end

Given /^User chooses group "(.*?)"$/ do |group_number|
 steps %{
   Then User replies with option "#{group_number}"
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
  group_no, _ = message.match(/(\d+) #{group_name}/i)
  steps %{
     Then User replies with option "#{group_no[1]}"
   }
end

Then /^User should see the groups list$/ do
	actual_response = @last_response.parsed_response
	s_no = 1
	@enrolled_groups.each do |enrolled_group|
    actual_response["message"].include?(enrolled_group.name).should == true
	s_no+=1
	end
	steps %{
		Then the JSON at "session_id" should be "#{@session_id}"
		Then the JSON at "session_type" should be "SESSION"

		}
		
	  actual_response["message"].include?("0 Home").should == true
end

Then /^User should see the ordered groups list on page "([^\"]*)"$/ do |page_no|
	actual_response = @last_response.parsed_response
	p actual_response
	page_no = page_no.to_i
	rpp = "#{RECORDS_PER_PAGE}".to_i
	s_no = (rpp * (page_no-1)) + 1
	start_index = rpp * (page_no-1)
  end_index = start_index + (rpp-1)
	@enrolled_groups.reverse[start_index..end_index].each do |enrolled_group|
		actual_response["message"].include?(enrolled_group.name).should == true
	end
	steps %{
		Then the JSON at "session_id" should be "#{@session_id}"
		Then the JSON at "session_type" should be "SESSION"

		}
end



Then /^User should only see group "([^\"]*)"$/ do |group_name|
  actual_response["message"].include?("1 #{group_name}").should == true
	steps %{
		Then the JSON at "session_id" should be "#{@session_id}"
		Then the JSON at "session_type" should be "SESSION"

		}
end

Then /^User should see the group menu page$/ do
  steps %{    
    Then the JSON at "message" should be "#{@messages.get("group_menu")}"
  }
end
