require "fake/internet"
require "detifm_podcast_page"

RSpec.describe DetifmPodcastPage do
  let(:podcast) do
    described_class.new(
      address,
      internet: Fake::Internet.new
    )
  end
  let(:address) { "https://www.deti.fm/program_child/uid/114343" }

  it { expect(podcast.title).to eq "ХРУМ, или Сказочный детектив" }
  it { expect(podcast.image).to eq "https://101.ru/vardata/modules/musicdb/files/202103/11/f0e2ff7ccc34af772194c9df6f235240.png?w=3000&h=3000" }

  it "has episodes" do
    expect(podcast.episodes.size).to eq 5

    expect(podcast.episodes.map(&:title)).to eq(
      [
        "Сказки Киплинга",
        "Сказки Френсис Бёрнет",
        "Домовёнок Кузя",
        "Золушка (новая версия)",
        "Гуси-Лебеди (новая версия)"
      ]
    )
  end
end
