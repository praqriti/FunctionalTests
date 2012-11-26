class Messages
  
def initialize
 @messages = {
    :teacher_with_no_quiz => "Attached to course as Teacher\\nNo Quiz Attached",
    :teacher_with_pending_invitation => "Attached to course as Teacher\\nPlease log in to Web, to respond to Course request",
    :student_with_no_quiz => "Attached to course as Student\\nNo Quiz Attached",
    :student_with_pending_invitation => "Attached to course as Student\\nPlease log in to Web, to respond to Course request",
    :invalid_option => "Invalid Option",
    :home_page => "Welcome to SEN!",
    :no_course_attached => "No Course Attached",
    :incorrect_credentials => "Incorrect Username/ Password",
    :status_updated => "Status Updated",
    :something_went_wrong => "Something went wrong. Please try again",
    :enter_password => "Enter your password",
    :no_score => "No score available",
    :single_attempt => "This was single attempt test and you have already attempted the test",
    :successful_test_attempt => "You have successfully finished the test"
  }
 end
 
 def get(message)
   @messages[message.to_sym]
 end
end
