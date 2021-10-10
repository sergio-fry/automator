require "veil"

class PersistedPodcasts
  include Enumerable

  def initialize(storage:, internet:)
    @storage = storage
    @internet = internet
  end

  def each
    @storage.podcasts.map do |p_data|
      yield Veil.new(
        DetifmPodcast.new(p_data[:address], internet: @internet),
        title: p_data[:title]
      )
    end
  end

  def add(podcast)
    @storage.save_podcast(podcast.address, {
      title: podcast.title,
      image: podcast.image,
      copyright: podcast.copyright,
      owner_email: podcast.owner_email,
      owner_name: podcast.owner_name,
      language: podcast.language,
      author: podcast.author,
      description: podcast.description,
      address: podcast.address
    })
  end
end
