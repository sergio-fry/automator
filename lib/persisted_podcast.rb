require "persisted_episode"

class PersistedPodcast
  def initialize(podcast, storage:)
    @podcast = podcast
    @storage = storage
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
      # PersistedEpisode.new(episode, storage: @storage).save
    end
  end

  def title
    data[:title]
  end

  def image
    data[:image]
  end

  def episodes
    data[:episodes]
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
