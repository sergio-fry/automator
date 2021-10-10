require "nokogiri"
require "stripped_text"
require "episode"
require "joined_uri"
require "internet"

class DetifmPodcast
  attr_reader :address

  def initialize(address, internet: Internet.new)
    @address = address
    @internet = internet
  end

  def guid
    address
  end

  def title
    StrippedText.new(
      Nokogiri::HTML(page).css(".podcast__description")[0].content
    ).to_s
  end

  def image
    Nokogiri::HTML(page).css("[rel=\"image_src\"]")[0].attr("href") + "?w=3000&h=3000"
  end

  def episodes
    Nokogiri::HTML(page).css(".podcasts__item-anonce").map do |el|
      DetifmEpisode.new(
        JoinedURI.new(
          "https://www.deti.fm/",
          el.css("a")[0].attr("href")
        ).to_s,
        internet: @internet
      )
    end
  end

  def page
    @page ||= @internet.read(@address).body
  end

  def language
    "ru"
  end

  def copyright
    author
  end

  def author
    "ООО «Аура-Радио»"
  end

  def description
    title
  end

  def owner_name
    author
  end

  def owner_email
    "radio@deti.fm"
  end
end
