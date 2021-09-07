class StrippedText
  def initialize(text)
    @text = text
  end

  def to_s
    @text.gsub(/^\s+/, "").gsub(/\s+$/, "")
  end
end
