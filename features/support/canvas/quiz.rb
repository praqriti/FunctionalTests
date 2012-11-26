module Canvas
  class CanvasBase
    protected
    def post resource, body
      response = JSONSpecInterface.post("#{CANVAS_URL}/courses/#{@course.id}/#{resource}",
                             :body =>  body.to_json,
                             :headers => { "Content-Type" => "application/json"},
                             :basic_auth => @auth)
      JSONSpecInterface.log(response)
      return response
    end
  end

  class Quiz < CanvasBase
    attr_accessor :title, :id, :due_at, :allowed_attempts

    def initialize user, course, assignment_group, title, allowed_attempts = "1", due_at = "3000-11-30T23:59:00-07:00"
      @auth = {:username => user.login_id, :password => user.password}
      @course = course
      @assignment_group = assignment_group
      @title = title
      @user = user
      @due_at = due_at
      @allowed_attempts = allowed_attempts
    end

    def create
      @last_response = post("quizzes", {
          :quiz => {
              :title => @title,
              :quiz_type => "assignment",
              :due_at => @due_at,
              :assignment_group_id => @assignment_group["id"],
              :allowed_attempts => @allowed_attempts
      }
      })
      @id = @last_response["quiz"]["id"]
      @assignment_id = @last_response["quiz"]["assignment_id"]
    end

    def add_question question
      @last_response = post("quizzes/#{@id}/questions.json", {
          :question => {
              :question_type=> "multiple_choice_question",
              :question_text => question[:text],
              :points_possible => question[:points],
              :answers => question[:answers]
          }
      })
    end

    def publish
      @last_response = post("quizzes/publish", {
          :quizzes => ["#{@id}"]
      })
    end

    def is_submitted?
      submissions = JSONSpecInterface.get("#{CANVAS_URL}/api/v1/courses/#{@course.id}/assignments/#{@assignment_id}/submissions",
                                        :headers => { "Content-Type" => "application/json", "Authorization" => CANVAS_ACCESS_TOKEN})
      JSONSpecInterface.log(submissions)

      return true if submissions.select{|s| s["user_id"] == @user.id && s["workflow_state"] == "graded" }.any?
      return false
    end

  end

  class AssignmentGroup < CanvasBase
    def initialize user, course
      @auth = {:username => user.login_id, :password => user.password}
      @course = course
    end

    def create
      @last_response = post("assignment_groups.json",  {
          :assignment_group => {
              :name => "USSD",
          }
      })
      @assignment_group = @last_response["assignment_group"]
      return @assignment_group
    end
  end
end
