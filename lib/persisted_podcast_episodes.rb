require "veil"

class PersistedPodcastEpisodes
  include Enumerable

  def initialize(podcast, storage:, internet:)
    @podcast = podcast
    @storage = storage
    @internet = internet
  end

  def each
    @storage.find_podcast_episodes(@podcast.address).map do |e_data|
      yield Veil.new(
        DetifmEpisode.new(e_data[:address], internet: @internet),
        {
          address: e_data[:address],
          audio: e_data[:audio],
          description: e_data[:description],
          guid: e_data[:guid],
          image: e_data[:image],
          title: e_data[:title]
        }
      )
    end
  end

  def add(episode)
    @storage.save_episode(
      episode.address,
      @podcast.address,
      {
        address: episode.address,
        audio: episode.audio,
        description: episode.description,
        guid: episode.guid,
        image: episode.image,
        title: episode.title
      }
    )
  end
end
