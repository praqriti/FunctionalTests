# # contains hooks to seed data
# 
# 
# Before do
#   #this code is run before each scenario
# end
# 
# After do
#   #this code is run after each scenario
# end
# 
at_exit do
   UserInterface.delete_user()
end

