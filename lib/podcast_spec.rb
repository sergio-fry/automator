require "fake_internet"
require "podcast"

RSpec.describe Podcast do
  let(:podcast) { described_class.new(address, FakeInternet.new) }
  let(:address) { "https://www.deti.fm/program_child/uid/114343" }

  it "has title" do
    expect(podcast.title).to eq "ХРУМ, или Сказочный детектив"
  end

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
