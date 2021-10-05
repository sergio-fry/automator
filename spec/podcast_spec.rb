require "feed"
require "detifm_podcast"

RSpec.describe "Get Podcast", development: true do
  it "get new episodes" do
    Feed.new(
      DetifmPodcast.new(
        "https://www.deti.fm/program_child/uid/114343"
      )
    ).xml
  end
end
