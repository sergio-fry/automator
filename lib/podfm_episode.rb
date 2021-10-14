require "nokogiri"
require "stripped_text"
require "internet"

class PodfmEpisode
  attr_reader :address

  def initialize(address, internet: Internet.new)
    @address = address
    @internet = internet
  end

  def title
    StrippedText.new(
      Nokogiri::HTML(page).css(".episode-title h4.title")[0].content
    ).to_s
  end

  def description
    title
  end

  def image
    "https://doodleipsum.com/3000x3000/abstract?i=f8b1abea359b643310916a38aa0b0562"
  end

  def audio
    Nokogiri::HTML(page).css(".podcast-episodes-item .actions a")[0].attr("href")
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
