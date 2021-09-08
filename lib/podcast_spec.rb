require "fake/internet"
require "podcast"

RSpec.describe Podcast do
  let(:podcast) { described_class.new(id, Fake::Internet.new) }
  let(:id) { "114343" }

  let(:page) { Support::Fixture.new("podcast/podcast.html").content }

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
