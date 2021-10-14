$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require "logger"
require "roda"
require "feed"
require "detifm_podcast"
require "podfm_podcast"
require "memory_storage"
require "persisted_podcasts"

class App < Roda
  logger = Logger.new($stdout)
  storage = MemoryStorage.new
  internet = Internet.new

  podcasts = PersistedPodcasts.new(
    storage: storage,
    internet: internet
  )

  Thread.new do
    ENV.fetch("DETIFM_PODCASTS", "114343,114386").split(",")
      .map { |uid| "https://www.deti.fm/program_child/uid/#{uid}" }
      .each do |address|
      logger.info "Updating podcast #{address} (FULL)"

      podcasts.add(
        DetifmPodcast.new(
          address,
          max_pages: ENV.fetch("DETIFM_PODCAST_MAX_PAGES", 10).to_i,
          internet: internet
        )
      )
    rescue => ex
      logger.error ex.message
      logger.error ex.backtrace.join("\n")
    end

    ENV.fetch("PODFM_PODCASTS", "klub-veselyh-akademikov").split(",").map { |slug| "https://podfm.ru/podcasts/#{slug}/" }.each do |address|
      logger.info "Updating podcast #{address} (FULL)"
      podcasts.add PodfmPodcast.new(address, internet: internet)
    end
    logger.info "Loaded"

    loop do
      sleep ENV.fetch("PODCASTS_REFRESH_INTERVAL", 3600).to_i

      podcasts.each do |podcast|
        logger.info "Updating podcast #{podcast.address}"

        podcasts.add podcast.refreshed
      rescue => ex
        logger.error ex.message
        logger.error ex.backtrace.join("\n")
      end
    end
  end

  def podcast_feed(response, podcasts, address)
    podcast = podcasts.find { |p| p.address == address }

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

  route do |r|
    r.root do
      "Hello!"
    end

    r.on "podcasts" do
      r.on "detifm", Integer do |uid|
        podcast_feed(response, podcasts, "https://www.deti.fm/program_child/uid/#{uid}")
      end
      r.on "podfm", String do |slug|
        podcast_feed(response, podcasts, "https://podfm.ru/podcasts/#{slug}/")
      end
    end
  end
end

run App.freeze.app
