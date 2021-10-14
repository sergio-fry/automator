require "nokogiri"
require "stripped_text"
require "podfm_episode"
require "joined_uri"
require "internet"

class PodfmPodcast
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
      Nokogiri::HTML(page).css(".podcast-title h4.title")[0].content
    ).to_s
  end

  def image
    "https://doodleipsum.com/3000x3000/abstract?i=f8b1abea359b643310916a38aa0b0562"
  end

  def episodes
    Nokogiri::HTML(page).css(".podcast-episode-item__info").map do |el|
      PodfmEpisode.new(
        el.css("a")[0].attr("href"),
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
