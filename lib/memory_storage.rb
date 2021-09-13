class MemoryStorage
  def initialize
    @data = {
      podcasts: {}
    }
  end

  def save_podcast(podcast)
    @data[:podcasts][podcast.guid] = {
      title: podcast.title,
      image: podcast.image,
      copyright: podcast.copyright,
      owner_email: podcast.owner_email,
      owner_name: podcast.owner_name,
      language: podcast.language,
      author: podcast.author,
      description: podcast.description
    }
  end

  def find_podcast(guid)
    @data[:podcasts][guid]
  end
end
