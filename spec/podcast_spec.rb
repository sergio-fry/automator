require "feed"
require "podcast"

RSpec.describe "Get Podcast", development: true do
  it "get new episodes" do
    Feed.new(
      Podcast.new(
        "https://www.deti.fm/program_child/uid/114343"
      )
    ).xml
  end
end
