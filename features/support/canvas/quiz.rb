module Canvas
  class CanvasBase
    protected
    def post resource, body
      JSONSpecInterface.post("#{CANVAS_URL}/courses/#{@course.id}/#{resource}",
                             :body =>  body.to_json,
                             :headers => { "Content-Type" => "application/json"},
                             :basic_auth => @auth)
    end

    def log object
      if object.nil?
        p "Operation failed for #{object} with #{@last_response.to_json}"
      end
    end
  end

  class Quiz < CanvasBase
    attr_reader :title

    def initialize user, course, assignment_group, title
      @auth = {:username => user.login_id, :password => user.password}
      @course = course
      @assignment_group = assignment_group
      @title = title
    end

    def create
      @last_response = post("quizzes", {
          :quiz => {
              :title => @title,
              :quiz_type => "assignment",
              :assignment_group_id => @assignment_group["id"]
          }
      })
      @id = @last_response["quiz"]["id"]
      log(@id)
    end

    def add_question question
      @last_response = post("quizzes/#{@id}/questions.json", {
          :question => {
              :question_type=> "multiple_choice_question",
              :question_text => question[:text],
              :answers => question[:answers]
          }
      })
    end

    def publish
      @last_response = post("quizzes/publish", {
          :quizzes => ["#{@id}"]
      })
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
      log(@assignment_group)
      return @assignment_group
    end
  end
end
