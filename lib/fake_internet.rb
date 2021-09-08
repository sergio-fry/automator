class FakeInternet
  def read(address)
    case address.to_s
    when "https://www.deti.fm/program_child/uid/114343"
      fixture("hrum/podcast.html")
    when "https://www.deti.fm/podcast__player/album/114343/uid/791582"
      fixture("hrum/episodes/kipling.html")
    when "https://www.deti.fm/podcast__player/album/114343/uid/784168"

      fixture("hrum/episodes/frensis.html")
    when "https://www.deti.fm/podcast__player/album/114343/uid/783470"

      fixture("hrum/episodes/kuzya.html")
    when "https://www.deti.fm/podcast__player/album/114343/uid/782186"

      fixture("hrum/episodes/zolushka.html")
    when "https://www.deti.fm/podcast__player/album/114343/uid/777933"
      fixture("hrum/episodes/gusi.html")
    else
      ""
    end
  end

  def fixture(path)
    File.read(File.join(File.dirname(__FILE__), "fake_internet", path))
  end
end
