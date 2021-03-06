# encoding: utf-8
class Messages
  
def initialize
 @messages = {
    :en => {
      :teacher_with_no_quiz => "Attached to course as Teacher\\nNo quiz attached\\n0 Previous Menu",
      :teacher_with_pending_invitation => "Attached to course as Teacher\\nPlease log in to Web, to respond to Course request\\n0 Previous Menu",
      :student_with_no_quiz => "Attached to course as Student\\nNo quiz attached\\n0 Previous Menu",
      :student_with_pending_invitation => "Attached to course as Student\\nPlease log in to Web, to respond to Course request\\n0 Previous Menu",
      :invalid_option => "Invalid Option",
      :home_page => "Welcome to SEN!\\n\\n1 Notifications\\n2 My Status\\n3 Connections\\n4 Groups\\n5 Courses",
      :no_course_attached => "No course attached\\n0 Previous Menu",
      :incorrect_credentials => "Incorrect Username/ Password",
      :status_updated => "Status Updated",
      :something_went_wrong => "Something went wrong. Please try again",
      :enter_password => "Enter your password",
      :no_score => "No score available\\n0 Previous Menu\\n*# Home",
      :single_attempt => "No attempts left for this quiz\\n0 Previous Menu\\n*# Home",
      :successful_test_attempt => "Successfully finished the test\\n0 Previous Menu\\n*# Home",
      :connection_menu => "1 My Connections[%s]\\n2 Connection Requests[%s]\\n0 Previous Menu",
      :group_menu => "No announcements on this group\\n1 Make New Announcement\\n0 Previous Menu\\n*# Home",
      :connection_request_accepted => "You and %s are now connected",
      :connection_request_rejected => "You have rejected %s's connection request",
      :connection_response_options => "1 Accept\n2 Reject\n0 Previous Menu\n*# Home",
      :connection_location => "Location: %s",
      :no_question_added_to_quiz => "No question added to quiz\\n0 Previous Menu\\n*# Home",
      :no_announcement_on_group => "No announcement on group\\n0 Previous Menu",
      :resume_menu => "1 Resume\\n2 Home",
      :previous_menu_option => "0 Previous Menu",
      :my_status_page => "1 Update Status\n2 Add Comment\n3 View Comments[0]\n0 Previous Menu",
      :my_status_add_comment => "Add Comment",
      :zero_comments => "View Comments[0]",
      :no_comments_msg => "No comments on status"
    },
    :sw => {
      :home_page => "Karibu sen!\\n\\n1 Ujulisho\\n2 My Hali\\n3 Rafiki\\n4 Vikundi\\n5 Kozi" ,
      :status_update => "1 Sasisha Hali\\n2 टिप्पण करें\\n3 View Comments[0]\\n0 Previous Menu" ,
      :connections_menu => ""
    }
  }
 end
 
 def get(message, options=[], locale = "en")
   @messages[locale.to_sym][message.to_sym] % options
 end
end

#You and requesting_user56... are now connected\n\n1 requesting_user49...\n2 requesting_user32...\n3 requesting_user27...\n4 requesting_user12...\n0 Previous Menu