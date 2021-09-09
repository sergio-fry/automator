class HTTPResponse
  attr_reader :body, :code

  def initialize(body, code)
    @body = body.to_s
    @code = code.to_i
  end
end
