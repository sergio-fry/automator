require "stripped_text"

class Episode
  def initialize(address, internet)
    @address = address
    @internet = internet
  end

  def title
    StrippedText.new(
      Nokogiri::HTML(page).css("h1")[0].content
    ).to_s
  end

  def page
    @internet.read @address
  end
end
