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
		actual_response["message"].include?(quiz.title).should == true
		s_no+=1
	end
	steps %{
		Then the JSON at "session_id" should be "#{@session_id}"
		Then the JSON at "session_type" should be "SESSION"

		}
	  actual_response["message"].include?("0 Home").should == true
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


Then /^User should see quiz menu for Student having "([^\"]*)" questions and "([^\"]*)" attempts available$/ do |question_count, attempts|
  actual_response = @last_response.parsed_response
  actual_response["message"].should == "Questions: #{question_count}\nPoints Possible: #{question_count}\nDue Date: Nov 30, 3000 at 23:59\nAttempts Available: #{attempts}\n1 View Score\n2 Attempt Quiz\n0 Home"
  actual_response["message"].include?("2 Attempt Quiz").should == true
  actual_response["message"].include?("1 View Score").should == true
  steps %{
		Then the JSON at "session_id" should be "#{@session_id}"
		Then the JSON at "session_type" should be "SESSION"

    		}
end

Then /^User should see quiz menu for Teacher having "([^\"]*)" questions and "([^\"]*)" total attempts$/ do |question_count, attempts|
   actual_response = @last_response.parsed_response
   actual_response["message"].should == "Questions: #{question_count}\nPoints Possible: #{question_count}\nDue Date: Nov 30, 3000 at 23:59\nTotal Attempts: #{attempts}\n1 View Report\n0 Home"
   actual_response["message"].include?("0 Home").should == true
   actual_response["message"].include?("1 View Report").should == true
  steps %{
		Then the JSON at "session_type" should be "SESSION"
  }
end

Then /^User should see quiz menu for role "([^\"]*)" having "([^\"]*)" questions and "([^\"]*)" attempts$/ do |role, question_count, attempts|
  actual_response = @last_response.parsed_response
  if (role == "Student")
    steps %{
      Then User should see quiz menu for Student having "#{question_count}" questions and "#{attempts}" attempts available
      }
  elsif (role == "Teacher")
    steps %{
      Then User should see quiz menu for Teacher having "#{question_count}" questions and "#{attempts}" total attempts
      }
  end
end

Then /^User should see the "Next" option on tests list$/ do
	actual_response = @last_response.parsed_response["response"]
  actual_response["message"].include?("# Next").should == true
end

Then /^User should see the "Previous" option on tests list$/ do
	actual_response = @last_response.parsed_response["response"]
  actual_response["message"].include?("* Previous").should == true
end

When /^User replies "0" from tests page to go back to home page$/ do
  steps %{
      Then User replies with option "0"   
    }
end

Given /^the following test data with questions exists:$/ do |test_table|
  test_table.hashes.each do |hash|
    status = hash[:STATUS]
    role = hash[:ROLE]
    course_name = hash[:COURSE]
    tests = hash[:TEST]
    allowed_attempts = hash[:ATTEMPTS].to_i
    question_count = hash[:QUESTIONS].to_i

    steps %{
       Given the following courses exist in canvas
        |COURSE|
        |#{course_name}|
    }

    course = @courses[0]
    @quizzes = []
    user = @users.find{|user| user.identifier == "camfed_user"}

    enrollment_id = CanvasEnrollmentInterface.enroll_user(course.id, user.id, CanvasEnrollmentInterface.enroll_type("Teacher"), "active")
    assignment_group = Canvas::AssignmentGroup.new(user, course).create
    quizzes = tests.split(",")
    @questions = []
    quizzes.each do |quiz_name|
      quiz = Canvas::Quiz.new(user, course, assignment_group, quiz_name, allowed_attempts)
      quiz.create
      if(question_count!=0)
				for i in 1..(question_count)
				  question = QuestionData.question
				  quiz.add_question question
				  @questions << question
				end
      end
      quiz.publish
      @quizzes << quiz
    end
    CanvasEnrollmentInterface.conclude_enrollment course.id, enrollment_id
    CanvasEnrollmentInterface.enroll_user(course.id, user.id, CanvasEnrollmentInterface.enroll_type(role), status)
  end
end

Then /^User should see the test report:$/ do |report_table|
  actual_response = @last_response.parsed_response["message"]
  report_table.hashes.each do |hash|
    actual_response.include?("Low Score: #{hash[:LOW_SCORE]}\n").should == true
    actual_response.include?("Average Correct: #{hash[:AVERAGE]}\n").should == true
    actual_response.include?("Students Attempted: #{hash[:STUDENTS_ATTEMPTED]}\n").should == true
    actual_response.include?("Mean Score: #{hash[:MEAN]}\n").should == true
    actual_response.include?("High Score: #{hash[:HIGH_SCORE]}\n").should == true

  end
end
