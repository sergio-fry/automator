class PersistedEpisode
  def initialize(origin, storage:)
    @origin = origin
    @storage = storage
  end

  def save(podcast_guid)
    @storage.save_episode(
      @origin.guid,
      podcast_guid,
      {
      }
    )
  end

  def title
    data[:title]
  end

  private

  def data
    @data ||= @storage.find(:episodes, @episode.guid)
  end
end
