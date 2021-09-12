$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require "roda"
require "feed"
require "multipage_podcast"

class App < Roda
  route do |r|
    r.root do
      "Hello!"
    end

    r.on "podcasts" do
      r.on "hrum" do
        response["Content-Type"] = "application/xml"

        Feed.new(
          MultipagePodcast.new(
            "https://www.deti.fm/program_child/uid/114343",
            max_pages: 3
          )
        ).xml
      end
    end
  end
end

run App.freeze.app
