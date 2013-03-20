class AnnouncementComment
  attr_reader :id, :user_name, :message

  def initialize( params={})
    params.symbolize_keys
    @id = params[:id]
    @user_name = params[:user_name]
    @message = params[:message]
  end

  def self.create(user, group, announcement, params={})
    @last_response =
        JSONSpecInterface.post("#{CANVAS_API}/groups/#{group.id}/discussion_topics/#{announcement.id}/entries",
                               :body =>  params,
                               :headers => { "Authorization" => "Bearer #{user.token}"}
        )
    #sleep(2)
    JSONSpecInterface.raise_error(@last_response)
    AnnouncementComment.new @last_response.parsed_response
  end
end