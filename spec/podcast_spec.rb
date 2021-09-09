require "podcast"

RSpec.describe "Get Podcast", development: true do
  it "get new episodes" do
    Podcast.new(
      "https://www.deti.fm/program_child/uid/114343"
    ).episodes.map(&:title)
  end
end
