class Announcement
  attr_reader :id, :title, :message

  def initialize( params={})
    params.symbolize_keys
    @id = params[:id]
    @title = params[:title]
    @message = params[:message]
  end

  def self.create(user, group, params={})    
    @last_response =
        JSONSpecInterface.post("#{CANVAS_API}/groups/#{group.id}/discussion_topics",
           :body =>  params.merge({
               :is_announcement => true
           }),
           :headers => { "Authorization" => "Bearer #{user.token}"}
        )
    sleep(2)
    JSONSpecInterface.raise_error(@last_response)
    Announcement.new @last_response.parsed_response
  end
  
  def self.create_for_course(user, course, params={})    
    @last_response =
        JSONSpecInterface.post("#{CANVAS_API}/courses/#{course.id}/discussion_topics",
           :body =>  params.merge({
               :is_announcement => true
           }),
           :headers => { "Authorization" => "Bearer #{user.token}"}
        )
    sleep(2)
    JSONSpecInterface.raise_error(@last_response)
    Announcement.new @last_response.parsed_response
  end
end