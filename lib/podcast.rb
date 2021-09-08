require "nokogiri"
require "stripped_text"
require "episode"

class Podcast
  def initialize(id, internet)
    @id = id
    @internet = internet
  end

  def title
    StrippedText.new(
      Nokogiri::HTML(page).css(".podcast__description")[0].content
    ).to_s
  end

  def episodes
    Nokogiri::HTML(page).css(".podcasts__item-anonce").map do |el|
      Episode.new(el.to_xml)
    end
  end

  def page
    @internet.read("https://www.deti.fm/program_child/uid/#{@id}")
  end
end
