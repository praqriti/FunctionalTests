class String
  def truncate character_limit
    str = self
    str = "#{str.slice(0..(character_limit-4))}..." if str.length > character_limit
    str
  end
end