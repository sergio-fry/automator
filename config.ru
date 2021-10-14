$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require "logger"
require "roda"
require "feed"
require "multipage_podcast"
require "memory_storage"
require "persisted_podcasts"

class App < Roda
  logger = Logger.new($stdout)
  storage = MemoryStorage.new
  internet = Internet.new
  podcasts_uids = ENV.fetch("DETIFM_PODCASTS", "114343,114386").split(",")

  podcasts = PersistedPodcasts.new(
    storage: storage,
    internet: internet
  )

  Thread.new do
    podcasts_uids.each do |uid|
      address = "https://www.deti.fm/program_child/uid/#{uid}"

      logger.info "Updating podcast #{address} (FULL)"

      podcasts.add(
        MultipagePodcast.new(
          address,
          max_pages: ENV.fetch("DETIFM_PODCAST_MAX_PAGES", 10).to_i,
          internet: internet
        )
      )

    rescue => ex
      logger.error ex.message
      logger.error ex.backtrace.join("\n")
    end

    loop do
      sleep ENV.fetch("PODCASTS_REFRESH_INTERVAL", 3600).to_i

      podcasts_uids.each do |uid|
        address = "https://www.deti.fm/program_child/uid/#{uid}"

        logger.info "Updating podcast #{address}"
        podcasts.add(
          MultipagePodcast.new(
            address,
            max_pages: 1,
            internet: internet
          )
        )
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
        podcast = podcasts.find { |p| p.address == "https://www.deti.fm/program_child/uid/#{uid}" }

        if !podcast.nil?
          response["Content-Type"] = "application/xml"
          Feed.new(
            podcast
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
