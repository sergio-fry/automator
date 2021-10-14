require "veil"
require "persisted_podcast_episodes"

class PersistedPodcasts
  include Enumerable

  def initialize(storage:, internet:)
    @storage = storage
    @internet = internet
  end

  def each
    @storage.podcasts.map do |p_data|
      podcast = DetifmPodcast.new(p_data[:address], internet: @internet)

      yield Veil.new(
        podcast,
        address: p_data[:address],
        description: p_data[:description],
        episodes: podcast_episodes(podcast),
        image: p_data[:image],
        title: p_data[:title]
      )
    end
  end

  def add(podcast)
    @storage.save_podcast(podcast.address, {
      address: podcast.address,
      author: podcast.author,
      copyright: podcast.copyright,
      description: podcast.description,
      image: podcast.image,
      language: podcast.language,
      owner_email: podcast.owner_email,
      owner_name: podcast.owner_name,
      title: podcast.title
    })

    podcast.episodes.each do |episode|
      podcast_episodes(podcast).add(episode)
    end
  end

  def podcast_episodes(podcast)
    PersistedPodcastEpisodes.new(podcast, internet: @internet, storage: @storage)
  end
end
