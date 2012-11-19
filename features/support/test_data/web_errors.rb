class Errors
  
def initialize
 @errors = {
    :page_not_found => "Page Not Found"
  }
end
  
def get(error)
 @errors[error.to_sym]
end

end
  