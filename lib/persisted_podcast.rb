require "veil"

require "detifm_episode"
require "episode"

class PersistedPodcast
  def initialize(origin, storage:, internet:)
    @origin = origin
    @storage = storage
    @internet = internet
  end

  def guid
    @origin.guid
  end

  def address
    data[:address]
  end

  def exists?
    !data.nil?
  end

  def save
    @storage.save_podcast(
      guid,
      {
        title: @origin.title,
        image: @origin.image,
        copyright: @origin.copyright,
        owner_email: @origin.owner_email,
        owner_name: @origin.owner_name,
        language: @origin.language,
        author: @origin.author,
        description: @origin.description,
        address: @origin.address
      }
    )

    @origin.episodes.each do |episode|
      @storage.save_episode(
        episode.guid,
        guid,
        {
          title: episode.title,
          description: episode.description,
          image: episode.image,
          audio: episode.audio,
          address: episode.address
        }
      )
    end
  end

  def title
    data[:title]
  end

  def image
    data[:image]
  end

  def episodes
    @storage.find_podcast_episodes(guid).map do |data|
      Veil.new(
        episode_klass(data[:address]).new(data[:address], internet: @internet),
        title: data[:title],
        description: data[:description],
        image: data[:image],
        audio: data[:audio],
        address: data[:address]
      )
    end
  end

  def episode_klass(address)
    DetifmEpisode
  end

  def language
    data[:language]
  end

  def copyright
    data[:copyright]
  end

  def author
    data[:author]
  end

  def description
    data[:description]
  end

  def owner_name
    data[:owner_name]
  end

  def owner_email
    data[:owner_email]
  end

  private

  def data
    @data ||= @storage.find_podcast(guid)
  end
end
