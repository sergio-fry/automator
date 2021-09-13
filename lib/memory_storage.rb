class MemoryStorage
  def initialize
    @data = {
      podcasts: {}
    }
  end

  def save(collection, id, data)
    @data[collection][id] = data
  end

  def find(collection, id)
    @data[collection][id]
  end
end
