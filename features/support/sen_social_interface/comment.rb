class Comment < SenSocialBase
  attr_accessor :id, :message, :status

  def initialize params, status
    @id = params["id"]
    @message = params["message"]
    @status = status
  end

  def self.create params
    status = params.delete :status
    response = self.post("users/#{status.user.id}/statuses/#{status.id}/comments.json", {
        :comment => {
            :message => params[:message]
        }
    }, params[:user])
    new(response, status)
    sleep(4)
  end
end