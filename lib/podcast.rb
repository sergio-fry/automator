require "nokogiri"
require "stripped_text"

class Podcast
  def initialize(page)
    @page = page
  end

  def title
    StrippedText.new(
      Nokogiri::HTML(@page).css(".podcast__description")[0].content
    ).to_s
  end

  def episodes
  end
end
