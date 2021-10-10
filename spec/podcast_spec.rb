require "feed"
require "memory_storage"
require "persisted_podcasts"
require "multipage_podcast"
require "detifm_podcast"

require "fake/internet"

RSpec.describe "Get Podcast", development: true do
  it "get new episodes" do
    storage = MemoryStorage.new
    internet = Fake::Internet.new

    podcasts = PersistedPodcasts.new(storage: storage, internet: internet)

    podcasts.add(
      MultipagePodcast.new(
        "https://www.deti.fm/program_child/uid/114343",
        max_pages: 1,
        internet: internet
      )
    )

    internet.disable

    Feed.new(
      podcasts.find { |podcast| podcast.address == "https://www.deti.fm/program_child/uid/114343" }
    ).xml
  end
end
