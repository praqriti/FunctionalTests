When /^User chooses course "([^\"]*)"$/ do |course_no|
  course_no = course_no.to_i
  steps %{
      Then User replies with option "#{course_no}"   
    }
end


Then /^User should see the tests for page "([^\"]*)"$/ do |page_no|
  actual_response = @last_response.parsed_response["response"]
	page_no = page_no.to_i
	rpp = "#{RECORDS_PER_PAGE}".to_i
	s_no = (rpp * (page_no-1)) + 1
	start_index = rpp * (page_no-1)
	end_index = start_index + (rpp-1)
	@quizzes[start_index..end_index].each do |quiz|
		actual_response["response_map"]["#{s_no}"]["text"].should == quiz.title
		s_no+=1
	end
	actual_response["response_map"]["0"]["text"].should == "Home"
	steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
		}
end

Given /^User publishes the course "([^\"]*)"$/ do |course_name|
  @course = @enrolled_courses.select { |c| c.name == course_name }.first

  steps %{
          When User is on the Sign In page
          And User "camfed_student" logs into Canvas with her credentials
          Then "camfed_student" should see the Canvas home page
          And User publishes the "#{course_name}" course
        }
end

And /^User chooses test "([^\"]*)"$/ do |test_no|
  test_no = test_no.to_i
  steps %{
      Then User replies with option "#{test_no}"   
    }
end


Then /^User should see quiz menu for role "([^\"]*)" having "([^\"]*)" questions$/ do |role, question_count|
  actual_response = @last_response.parsed_response["response"]
  actual_response["message"].should == "Questions: #{question_count}\nPoints Possible: #{question_count}\nDue Date: Nov 30, 3000 at 23:59"
  if (role == "student")
    actual_response["response_map"]["2"]["text"].should == "Attempt Quiz"
    actual_response["response_map"]["1"]["text"].should == "View Score"
  elsif (role == "teacher")
    actual_response["response_map"]["1"]["text"].should == "View Report"
  end
    actual_response["response_map"]["0"]["text"].should == "Home"
  steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
    		}
end


Then /^User should see the "Next" option on tests list$/ do
	actual_response = @last_response.parsed_response["response"]
	actual_response["response_map"]["#"]["text"].should  == "Next"
end

Then /^User should see the "Previous" option on tests list$/ do
	actual_response = @last_response.parsed_response["response"]
	actual_response["response_map"]["*"]["text"].should  == "Previous"
end

When /^User replies "0" from tests page to go back to home page$/ do
  steps %{
      Then User replies with option "0"   
    }
end

Given /^the following test data exists:$/ do |test_table|
  test_table.hashes.each do |hash|
    status = hash[:STATUS]
    role = hash[:ROLE]
    course_name = hash[:COURSE]
    tests = hash[:TESTS]

    steps %{
       Given the following courses exist in canvas
        |COURSE|
        |#{course_name}|
    }

    course = @courses[0]
    @quizzes = []
    user = CanvasUserInterface.get_user

    enrollment_id = CanvasEnrollmentInterface.enroll_user(course.id, user.id, CanvasEnrollmentInterface.enroll_type("Teacher"), "active")
    assignment_group = Canvas::AssignmentGroup.new(user, course).create
    quizzes = tests.split(",")
    quizzes.each do |quiz_name|
      quiz = Canvas::Quiz.new(user, course, assignment_group, quiz_name)
      quiz.create
      quiz.publish
      @quizzes << quiz
    end
    CanvasEnrollmentInterface.conclude_enrollment course.id, enrollment_id
    CanvasEnrollmentInterface.enroll_user(course.id, user.id, CanvasEnrollmentInterface.enroll_type(role), status)
  end
end

Given /^the following test data with questions exists:$/ do |test_table|
  test_table.hashes.each do |hash|
    status = hash[:STATUS]
    role = hash[:ROLE]
    course_name = hash[:COURSE]
    tests = hash[:TEST]

    steps %{
       Given the following courses exist in canvas
        |COURSE|
        |#{course_name}|
    }

    course = @courses[0]
    @quizzes = []
    user = CanvasUserInterface.get_user

    enrollment_id = CanvasEnrollmentInterface.enroll_user(course.id, user.id, CanvasEnrollmentInterface.enroll_type("Teacher"), "active")
    assignment_group = Canvas::AssignmentGroup.new(user, course).create
    quizzes = tests.split(",")
    @questions = []
    quizzes.each do |quiz_name|
      quiz = Canvas::Quiz.new(user, course, assignment_group, quiz_name)
      quiz.create
      for i in 1..2
        question = QuestionData.question
        quiz.add_question question
        @questions << question
      end
      quiz.publish
      @quizzes << quiz
    end
    CanvasEnrollmentInterface.conclude_enrollment course.id, enrollment_id
    CanvasEnrollmentInterface.enroll_user(course.id, user.id, CanvasEnrollmentInterface.enroll_type(role), status)
  end
end




