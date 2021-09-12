require "nokogiri"

class Feed
  def initialize(podcast)
    @podcast = podcast
  end

  def xml
    Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
      xml.rss(
        "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",
        "version" => "2.0",
        "xmlns:atom" => "http://www.w3.org/2005/Atom",
        "xmlns:rawvoice" => "http://www.rawvoice.com/rawvoiceRssModule/"
      ) do
        xml.channel do
          xml.title @podcast.title
          xml.link @podcast.address
          xml.pubDate Time.now.iso8601
          xml.lastBuildDate Time.now.iso8601

          xml["atom10"].link(
            "xmlns:atom10" => "http://www.w3.org/2005/Atom",
            :rel => "hub",
            # :type => "application/rss+xml",
            :href => "http://pubsubhubbub.appspot.com/"
          )

          xml["itunes"].image(href: @podcast.image)
          xml["itunes"].category "Kids &amp; Family"

          # xml.language @podcast.language
          # xml["itunes"].author @podcast.author
          # xml.description @podcast.description
          # xml["itunes"].type "serial"
          # xml["itunes"].owner do
          # xml["itunes"].name @podcast.owner_name
          # xml["itunes"].email @podcast.owner_email
          # end

          @podcast.episodes.each do |episode|
            xml.item do
              xml.title episode.title
              xml.link episode.address
              xml.pubDate Time.now.iso8601
              xml.description do
                xml.cdata episode.description
              end
              xml.enclosure(type: "audio/mp3", url: episode.audio)
              xml.guid episode.guid
              xml["itunes"].summary do
                xml.cdata episode.description
              end
              xml["itunes"].image(href: episode.image)
              xml["itunes"].keywords "сказки,дети"
              xml["itunes"].explicit "no"
            end
          end
        end
      end
    end.to_xml
  end
end
