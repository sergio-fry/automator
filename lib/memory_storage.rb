class MemoryStorage
  def initialize
    @data = {
      podcasts: {},
      episodes: {}
    }
  end

  def save_podcast(guid, data)
    @data[:podcasts][guid] = data
  end

  def find_podcast(guid)
    @data[:podcasts][guid]
  end

  def save_episode(guid, podcast_guid, data)
    @data[:episodes][guid] = data.merge(podcast_guid: podcast_guid)
  end

  def find_podcast_episodes(podcast_guid)
    @data[:episodes].values.find_all do |el|
      el[:podcast_guid] == podcast_guid
    end
  end
end
