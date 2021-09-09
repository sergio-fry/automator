require "nokogiri"
require "stripped_text"
require "episode"
require "joined_uri"
require "internet"

class Podcast
  def initialize(address, internet: Internet.new)
    @address = address
    @internet = internet
  end

  def title
    StrippedText.new(
      Nokogiri::HTML(page).css(".podcast__description")[0].content
    ).to_s
  end

  def episodes
    Nokogiri::HTML(page).css(".podcasts__item-anonce").map do |el|
      Episode.new(
        JoinedURI.new(
          "https://www.deti.fm/",
          el.css("a")[0].attr("href")
        ).to_s,
        internet: @internet
      )
    end
  end

  def page
    @internet.read(@address).body
  end
end
