class SenSocialBase
  def self.post resource, body, user
    response = JSONSpecInterface.post("#{SEN_SOCIAL_URL}/#{resource}",
                             :body =>  body.to_json,
                             :headers =>
                                 {
                                    "Content-Type" => "application/json",
                                    "AUTHORIZATION" => "Bearer #{user.token}"
                                 })
    JSONSpecInterface.raise_error(response)
    return response
  end
end
