require "nokogiri"
require "stripped_text"

class Episode
  attr_reader :address

  def initialize(address, internet:)
    @address = address
    @internet = internet
  end

  def title
    StrippedText.new(
      Nokogiri::HTML(page).css("h1")[0].content
    ).to_s
  end

  def description
    title
  end

  def image
    Nokogiri::HTML(page).css(".podcasts__share_link")[0].attr("data-image") + "?w=3000&h=3000"
  end

  def audio
    Nokogiri::HTML(page).css(".mplayer-block-play audio")[0].attr("src")
  end

  def file_size
    1
  end

  def page
    @page ||= @internet.read(@address).body
  end

  def guid
    @address
  end
end
