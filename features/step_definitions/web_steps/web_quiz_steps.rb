
Given /^User navigates to quiz page and creates the following:$/ do |quiz_table|
  quiz_table.hashes.each do |hash|
  course = @courses.select { |c| c.name == hash[:COURSE] }.first
  user = @users.find{|user| user.identifier == hash[:USER]}
  @quizzes = hash[:TESTS].split(",")
  
  enrollment_id = CanvasEnrollmentInterface.enroll_user(course.id, user.id, "TeacherEnrollment", "active")
  
  steps %{
    And User is on the Sign In page
    And User "#{user.identifier}" logs into Canvas with her credentials
    And User sets the quiz group as "USSD" for course "#{course.name}"
  }
  Quizzes.set_page_url course.id
   @quizzes.each do |quiz_name|
     steps %{
       And User creates quiz "#{quiz_name}" for group "#{hash[:GROUP]}"
     }
   end
   CanvasEnrollmentInterface.conclude_enrollment course.id, enrollment_id
 end
end

Given /^User sets the quiz group as "([^\"]*)" for course "([^\"]*)"$/ do |group_name,course_name|
  
  course = @courses.select { |c| c.name == course_name }.first
  Assignment.set_page_url course.id
  @app.assignment.load
  @app.assignment.add_group.click
  @app.assignment.group_name.set "#{group_name}"
  @app.assignment.update_button.click
  @app.assignment.group.text.should == "#{group_name}:"

end

Then /^User creates quiz "([^\"]*)" for group "([^\"]*)"$/ do |quiz_name,quiz_group|
    @app.quiz.load
    @app.quiz.wait_until_new_quiz_button_visible
    @app.quiz.new_quiz_button.click
    @app.quiz.wait_until_publish_button_visible
    page.select "#{quiz_group}", :from => 'quiz_assignment_group_id'
    @app.quiz.quiz_name_field.set "#{quiz_name}"
    @app.quiz.publish_button.click
    @app.quiz.wait_until_quiz_name_header_visible
end

And /^User navigates to quiz "([^\"]*)" for course "([^\"]*)"$/ do |quiz_name, course_name|
  course = @courses.select { |c| c.name == course_name }.first
  quiz = @quizzes.select {|q| q.title == quiz_name}.first
  Quiz.set_page_url course.id, quiz.id
  @app.one_quiz.load
  @app.one_quiz.wait_until_resume_visible
end

And /^User resumes the quiz$/ do
  @app.one_quiz.resume.click
end

Then /^User should see option "([^\"]*)" choosen for question "([^\"]*)"$/ do |option_number, question_number|
  question_number = (question_number.to_i)-1
  option_number = (option_number.to_i)-1
  @app.one_quiz.questions[question_number].options[option_number].checked?
end


