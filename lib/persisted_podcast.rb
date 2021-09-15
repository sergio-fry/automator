require "persisted_episode"

class PersistedPodcast
  def initialize(podcast, storage:)
    @podcast = podcast
    @storage = storage
  end

  def guid
    @podcast.guid
  end

  def save
    @storage.save_podcast(
      @podcast.guid,
      {
        title: @podcast.title,
        image: @podcast.image,
        copyright: @podcast.copyright,
        owner_email: @podcast.owner_email,
        owner_name: @podcast.owner_name,
        language: @podcast.language,
        author: @podcast.author,
        description: @podcast.description
      }
    )

    @podcast.episodes.each do |episode|
      PersistedEpisode.new(episode, storage: @storage).save(podcast_guid: guid)
    end
  end

  def title
    data[:title]
  end

  def image
    data[:image]
  end

  def episodes
    @storage.find_podcast_episodes(guid).map do |guid|
      PersistedEpisode.new(Episode.new(guid), storage: @storage)
    end
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
    @data ||= @storage.find_podcast(@podcast.guid)
  end
end
