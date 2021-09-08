class JoinedURI
  def initialize(*parts)
    @parts = parts
  end

  def to_s
    URI.join(*@parts)
  end
end
