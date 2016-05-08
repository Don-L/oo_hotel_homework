class ManagerPrompt

attr_accessor(:query, :options_list)

def initialize(query, options_list)
  @query = query
  @options_list = options_list
end

end