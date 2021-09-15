class PersistedEpisode
  def initialize(origin, storage:)
    @origin = origin
    @storage = storage
  end

  def save(podcast_guid:)
    @storage.save_episode(
      @origin.guid,
      podcast_guid,
      {
        title: @origin.title,
        image: @origin.image,
        audio: @origin.audio,
        address: @origin.address
      }
    )
  end

  def title
    data[:title]
  end

  def image
    data[:image]
  end

  def audio
    data[:audio]
  end

  def address
    data[:address]
  end

  def guid
    @origin.guid
  end

  def description
    data[:description]
  end

  private

  def data
    @data ||= @storage.find_episode(@origin.guid)
  end
end
