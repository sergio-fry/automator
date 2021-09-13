require "podcast"

class MultipagePodcast
  attr_reader :address

  def initialize(address, max_pages: 3)
    @address = address
    @max_pages = max_pages
  end

  def podcast(page = 1)
    Podcast.new(@address + "/page/#{page}")
  end

  def title
    podcast.title
  end

  def image
    podcast.image
  end

  def episodes
    (1..@max_pages).map do |page|
      podcast(page).episodes
    end.flatten
  end

  def language
    podcast.language
  end

  def copyright
    podcast.copyright
  end

  def author
    podcast.author
  end

  def description
    podcast.description
  end

  def owner_name
    podcast.owner_name
  end

  def owner_email
    podcast.owner_email
  end
end