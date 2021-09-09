require "nokogiri"
require "stripped_text"

class Episode
  def initialize(address, internet:)
    @address = address
    @internet = internet
  end

  def title
    StrippedText.new(
      Nokogiri::HTML(page).css("h1")[0].content
    ).to_s
  end

  def image
    Nokogiri::HTML(page).css(".podcasts__share_link")[0].attr("data-image")
  end

  def audio
    Nokogiri::HTML(page).css(".mplayer-block-play audio")[0].attr("src")
  end

  def page
    @internet.read(@address).body
  end
end
