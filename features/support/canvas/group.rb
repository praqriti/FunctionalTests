class Group
  attr_reader :id, :name, :join_level, :member_count, :context_type

  def initialize( params={})
    params.symbolize_keys
    @id = params[:id]
    @name = params[:name]
    @public = params[:is_public]
    @join_level = params[:join_level]
    @member_count = params[:member_count]
  end

  def self.create(params={})
    name = params[:name]
    public = params[:public] || true
    join_level = params[:join_level] || "parent_context_auto_join"
    context_type = params[:type]
    
    @last_response =
        JSONSpecInterface.post("#{CANVAS_API}/groups",
           :body =>  {
               :name => name,
               :is_public => public,
               :join_level => join_level,
               :context_type => context_type,
               :account_id => ACCOUNT_ID
           },
           :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"}
        )
    JSONSpecInterface.raise_error(@last_response)
    sleep(2)
    Group.new @last_response.parsed_response
  end


  def public?
    @public
  end

  def join user
    @last_response =
        JSONSpecInterface.post("#{CANVAS_API}/groups/#{id}/memberships",
           :body =>  {
               :user_id => "self"
           },
           :headers => { "Authorization" => "Bearer #{user.token}"}
        )
    JSONSpecInterface.raise_error(@last_response)
  end

  def delete
    @delete_response = JSONSpecInterface.delete("#{CANVAS_API}/groups/#{id}",
      :body => {
        :event => "delete"
      },
      :headers => { "Authorization" => "#{CANVAS_ACCESS_TOKEN}"})
    JSONSpecInterface.raise_error(@last_response)
  end

end