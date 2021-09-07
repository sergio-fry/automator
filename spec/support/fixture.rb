module Support
  class Fixture
    def initialize(path)
      @path = path
    end

    def content
      File.read(File.join(File.dirname(__FILE__), "..", @path))
    end
  end
end
