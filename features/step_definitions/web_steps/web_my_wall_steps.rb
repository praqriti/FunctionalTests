Given /^User lands on My Wall and can view all the elements$/ do
   @app.my_wall = MyWall.new
   @app.my_wall.wait_until_user_name_visible
   @app.my_wall.all_there?
end

Given /^User clicks on My Wall$/ do
  @app.home.menu.my_wall.click
  steps %{
    Then User lands on My Wall and can view all the elements
  }
end

Then /^User can view her latest status message "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^User can view the comments attached to the status message$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^User can view the information of the user who has commented on the status message$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^User comments "(.*?)" on her status message$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the comment is visible on My Wall$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^User can view her latest status message$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^User cannot enter blank comment on the status$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^User comments on her status message:$/ do |string|
  pending # express the regexp above with the code you wish you had
end

Then /^the comment visible is:$/ do |string|
  pending # express the regexp above with the code you wish you had
end

Then /^the comment "(.*?)" is visible on top of My Wall$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^User must be able to navigate to the wall of  "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end


