require "nokogiri"

class Feed
  def initialize(podcast)
    @podcast = podcast
  end

  def xml
    Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
      xml.root(
        "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",
        "version" => "2.0"
      ) do
        xml.channel do
          xml.title @podcast.title
          xml.link @podcast.address
          xml.language @podcast.language
          xml.copyright @podcast.copyright
          xml["itunes"].author @podcast.author
          xml.description @podcast.description
          xml["itunes"].type "serial"
          xml["itunes"].owner do
            xml["itunes"].name @podcast.owner_name
            xml["itunes"].name @podcast.owner_email
          end
          xml["itunes"].image @podcast.image

          @podcast.episodes.each do |episode|
            xml.item do
              xml["itunes"].title episode.title
              xml.description do
                xml.cdata episode.description
              end
              xml.enclosure(length: episode.enclosure_length, type: "audio/mpeg", url: episode.enclosure_url)
              xml.guid episode.guid
            end
          end
        end
      end
    end.to_xml
  end
end
