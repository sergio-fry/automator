require "http"
require "http_response"

class Internet
  def read(address)
    resp = HTTP.get(address)

    HTTPResponse.new(resp.body, resp.code)
  end
end
