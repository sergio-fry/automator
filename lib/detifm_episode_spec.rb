require "detifm_episode"
require "fake_internet"

RSpec.describe DetifmEpisode do
  subject(:episode) { described_class.new "https://www.deti.fm/podcast__player/album/114343/uid/791582", internet: FakeInternet.new }
  it { expect(episode.title).to eq "Сказки Киплинга" }
  it { expect(episode.image).to eq "https://101.ru/vardata/modules/musicdb/files/202103/11/f0e2ff7ccc34af772194c9df6f235240.png?w=3000&h=3000" }
  it { expect(episode.audio).to eq "https://101.ru/vardata/modules/musicdb/files/202109/35/721e12b0322acbe8e347f561e8a18e68.mp3" }
end
