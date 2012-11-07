When /^User chooses course "([^\"]*)"$/ do |course_no|
  course_no = course_no.to_i
  body = @last_response.parsed_response
  body.merge!({"message" => "#{course_no}"})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                          :body => body.to_json,
                                          :headers => { "Content-Type" => "application/json"})
end


Then /^User should see the tests for page "([^\"]*)"$/ do |page_no|
  actual_response = @last_response.parsed_response
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
  body = @last_response.parsed_response
  body.merge!({"message" => "#{test_no}"})
  @last_response = JSONSpecInterface.post("#{SEN_URL}",
                                          :body => body.to_json,
                                          :headers => { "Content-Type" => "application/json"})
end


Then /^User should see the "([^\"]*)" menu$/ do |role|
  user_id = CanvasUserInterface.get_user_id
  actual_response = @last_response.parsed_response
  if (role == "student")
    actual_response["response_map"]["2"]["text"].should == "Attempt Quiz"
    actual_response["response_map"]["1"]["text"].should == "View Score"   
  elsif (role == "teacher")
    actual_response["response_map"]["1"]["text"].should == "View Report"
  end
   actual_response["response_map"]["0"]["text"].should == "Home"
   actual_response["response_map"]["0"]["url"].should  == "sen/users/#{user_id}"
  steps %{
		Then the JSON at "session_id" should be "session id"
		Then the JSON at "session_type" should be "SESSION"
		Then the JSON should have "access_token"
    		}
end


Then /^User should see the "Next" option on tests list$/ do
	user_id = CanvasUserInterface.get_user_id
	course_id = CanvasCourseInterface.get_course_id
	actual_response = @last_response.parsed_response
	actual_response["response_map"]["#"]["url"].should  == "sen/users/#{user_id}/courses/#{course_id}/quizzes/?page=2"
	actual_response["response_map"]["#"]["text"].should  == "Next"
end

Then /^User should see the "Previous" option on tests list$/ do
	user_id = CanvasUserInterface.get_user_id
	course_id = CanvasCourseInterface.get_course_id
	actual_response = @last_response.parsed_response
	actual_response["response_map"]["*"]["url"].should  == "sen/users/#{user_id}/courses/#{course_id}/quizzes/?page=1"
	actual_response["response_map"]["*"]["text"].should  == "Previous"
end

When /^User replies "0" from tests page to go back to home page$/ do
	user_id = CanvasUserInterface.get_user_id
	body = @last_response.parsed_response.merge!({"message" => "0"})
	@last_response = JSONSpecInterface.post("#{SEN_URL}",
       	:body =>body.to_json,
	:headers => { "Content-Type" => "application/json"})
end

def enroll_user_to_course(course, type)
  enroll_type = type == "Teacher" ? "TeacherEnrollment" : "StudentEnrollment"
  user_id = CanvasUserInterface.get_user_id
  CanvasEnrollmentInterface.enroll_user(course.id, user_id, enroll_type, "active")
end

def create_course(course_name)
  steps %{
       Given the following courses exist in canvas
        |COURSE|
        |#{course_name}|
    }
  return @courses[0]
end


def create_quizzes(course, quizzes_table)
  @quizzes = []
  user = CanvasUserInterface.get_user

  enrollment_id = enroll_user_to_course course, "Teacher"

  assignment_group = Canvas::AssignmentGroup.new(user, course).create
  quizzes = quizzes_table.split(",")
  quizzes.each do |quiz_name|
    quiz = Canvas::Quiz.new(user, course, assignment_group, quiz_name)
    quiz.create
    quiz.publish
    @quizzes << quiz
  end
#
#question = {
#    :text => "huhahahaha",
#    :answers => {
#        "answer_0" => {
#            "answer_weight" => 100,
#            "answer_text" => "ddssd"
#        },
#
#        "answer_1" => {
#            "answer_weight" => 0,
#            "answer_text" => "ddssdssd"
#        }
#    }
#}
#quiz.add_question question
  CanvasEnrollmentInterface.conclude_enrollment course.id, enrollment_id
end

Given /^the following test data exists:$/ do |test_table|
  test_table.hashes.each do |hash|
    role = hash[:ROLE]
    course_name = hash[:COURSE]
    tests = hash[:TESTS]

    course = create_course(course_name)
    create_quizzes(course, tests)
    enroll_user_to_course(course, role)
  end
end




