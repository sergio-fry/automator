require "http_response"

module Fake
  class Internet
    def read(address)
      case address.to_s
      when "https://www.deti.fm/program_child/uid/114343"
        HTTPResponse.new(fixture("hrum/podcast.html"), 200)
      when "https://www.deti.fm/podcast__player/album/114343/uid/791582"
        HTTPResponse.new(fixture("hrum/episodes/kipling.html"), 200)
      when "https://www.deti.fm/podcast__player/album/114343/uid/784168"

        HTTPResponse.new(fixture("hrum/episodes/frensis.html"), 200)
      when "https://www.deti.fm/podcast__player/album/114343/uid/783470"

        HTTPResponse.new(fixture("hrum/episodes/kuzya.html"), 200)
      when "https://www.deti.fm/podcast__player/album/114343/uid/782186"

        HTTPResponse.new(fixture("hrum/episodes/zolushka.html"), 200)
      when "https://www.deti.fm/podcast__player/album/114343/uid/777933"
        HTTPResponse.new(fixture("hrum/episodes/gusi.html"), 200)
      else
        HTTPResponse.new("", 404)
      end
    end

    def fixture(path)
      File.read(File.join(File.dirname(__FILE__), "internet", path))
    end
  end
end
