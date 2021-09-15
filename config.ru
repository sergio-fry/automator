$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require "logger"
require "roda"
require "feed"
require "multipage_podcast"
require "memory_storage"
require "persisted_podcast"

class App < Roda
  logger = Logger.new($stdout)
  storage = MemoryStorage.new

  Thread.new do
    loop do
      ENV.fetch("DETIFM_PODCASTS", "114343,114386")
        .split(",")
        .each do |uid|
        address = "https://www.deti.fm/program_child/uid/#{uid}"

        podcast = PersistedPodcast.new(
          MultipagePodcast.new(
            address,
            max_pages: ENV.fetch("DETIFM_PODCAST_MAX_PAGES", 10).to_i
          ),
          storage: storage
        )

        logger.info "Updating podcast #{address}"

        podcast.save
      end

      sleep ENV.fetch("PODCASTS_REFRESH_INTERVAL", 3600).to_i
    end
  end

  route do |r|
    r.root do
      "Hello!"
    end

    r.on "podcasts" do
      r.on "detifm", Integer do |uid|
        persisted_podcast = PersistedPodcast.new(
          Podcast.new(
            "https://www.deti.fm/program_child/uid/#{uid}"
          ),
          storage: storage
        )

        if persisted_podcast.exists?
          response["Content-Type"] = "application/xml"
          Feed.new(
            persisted_podcast
          ).xml
        else
          response.status = 404
          "Not found"
        end
      end
    end
  end
end

run App.freeze.app
