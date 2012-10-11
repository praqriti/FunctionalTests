# Given /^the following user exists in canvas:$/ do |users_table|
#   # User.create_users(users_table)
#   #  user
#     users_table.hashes.each do |hash|  
#       # CanvasUserInterface.create_user("#{hash["USER"]}")
#     end
# end
# 
# #doesnt work
# Then /^the following users are removed from canvas:$/ do |users_table|
#    users_table.hashes.each do |hash|
#      CanvasUserInterface.delete_user("#{hash["USER"]}")
#   end
# end
# # 