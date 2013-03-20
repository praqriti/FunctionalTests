Given /^I should see the app in "([^\"]*)"$/ do |language|


  steps %{
  Then User should see the USSD home page in "#{language}"


  Then User replies with option "2"
  Then User should see update status message in "#{language}"

  Then User replies with option "0"
  Then User replies with option "3"
  Then User should see connections menu in "#{language}"
        }
end

#Then User navigates to connections menu
#Then User should see the USSD connections menu in "#{language}"
#
#Then User navigates to quiz menu
#Then User should see the USSD quiz menu in "#{language}"
#
#Then User navigates to announcement menu
#Then User should see the announcement menu in "#{language}"
#
#Then User navigates to connection status menu
#Then User should see the connection status menu in "#{language}"
