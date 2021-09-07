require "stripped_text"

class Episode
  def initialize(content)
    @content = content
  end

  def title
    StrippedText.new(
      Nokogiri::HTML(@content).css(".podcasts__item-name")[0].content
    ).to_s
  end
end
