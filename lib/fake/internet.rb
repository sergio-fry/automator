module Fake
  class Internet
    def read(address)
      case address
      when "https://www.deti.fm/program_child/uid/114343"
        fixture("podcast.html")
      end
    end

    def fixture(path)
      File.read(File.join(File.dirname(__FILE__), "internet", path))
    end
  end
end
