class Status < SenSocialBase
  attr_accessor :id, :message, :user

  def initialize params, user
    @id = params[:id]
    @message = params[:message]
    @user = user
  end

  def self.create params
      response = self.post("users/self/status.json", {
          :status => {
              :message => params[:message]
          }
      }, params[:user])
    new(response, params[:user])
  end
end