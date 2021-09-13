class PersistedEpisode
  def initialize(episode, storage:)
    @episode = episode
    @storage = storage
  end

  def save
    @storage.save(
      :episodes,
      @episode.guid,
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
