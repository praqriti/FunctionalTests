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
    :incorrect_credentials => "Incorrect Username/ Password\\n"
    :status_updated => "Status Updated\\n"
    :something_went_wrong => "Something went wrong. Please try again"
    :enter_password => "Enter your password"
  }
 end
 
 def get(message)
   @messages[message.to_sym]
 end
end