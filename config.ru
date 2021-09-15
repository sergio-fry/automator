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
  podcasts_uids = ENV.fetch("DETIFM_PODCASTS", "114343,114386").split(",")

  class UpdatedPodcast
    def initialize(address, storage:, max_pages:)
      @address = address
      @storage = storage
      @max_pages = max_pages
    end

    def update
      persisted_podcast.save
    end

    def persisted_podcast
      PersistedPodcast.new(
        MultipagePodcast.new(
          @address,
          max_pages: @max_pages
        ),
        storage: @storage
      )
    end
  end

  Thread.new do
    podcasts_uids.each do |uid|
      address = "https://www.deti.fm/program_child/uid/#{uid}"

      logger.info "Updating podcast #{address} (FULL)"
      UpdatedPodcast.new(
        address,
        storage: storage,
        max_pages: ENV.fetch("DETIFM_PODCAST_MAX_PAGES", 10).to_i
      ).update
    rescue => ex
      logger.error ex.message
      logger.error ex.backtrace.join("\n")
    end

    loop do
      sleep ENV.fetch("PODCASTS_REFRESH_INTERVAL", 3600).to_i

      podcasts_uids.each do |uid|
        address = "https://www.deti.fm/program_child/uid/#{uid}"

        logger.info "Updating podcast #{address}"
        UpdatedPodcast.new(address, storage: storage, max_pages: 1).update
      rescue => ex
        logger.error ex.message
        logger.error ex.backtrace.join("\n")
      end
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
