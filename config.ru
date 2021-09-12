$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require "roda"
require "feed"
require "podcast"

class App < Roda
  route do |r|
    r.root do
      "Hello!"
    end

    r.on "podcasts" do
      r.on "hrum" do
        response["Content-Type"] = "application/xml"

        Feed.new(
          Podcast.new(
            "https://www.deti.fm/program_child/uid/114343"
          )
        ).xml
      end

      r.on "valid" do
        response["Content-Type"] = "application/xml"

        File.read("valid.xml")
      end
    end
  end
end

run App.freeze.app
