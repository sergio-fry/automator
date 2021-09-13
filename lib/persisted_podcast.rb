class PersistedPodcast
  def initialize(guid, storage:)
    @guid = guid
    @storage = storage
  end

  def title
    data[:title]
  end

  def image
    data[:image]
  end

  def episodes
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
    @data ||= @storage.find_podcast(@guid)
  end
end
