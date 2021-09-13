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

  def find(collection, id)
    @data[collection][id]
  end
end
