require "fake/internet"
require "podfm_podcast"

RSpec.describe PodfmPodcast do
  let(:podcast) do
    described_class.new(
      address,
      internet: Fake::Internet.new
    )
  end
  let(:address) { "https://podfm.ru/podcasts/klub-veselyh-akademikov/" }

  it { expect(podcast.title).to eq "Клуб веселых академиков" }
  it { expect(podcast.image).to eq "https://doodleipsum.com/3000x3000/abstract?i=f8b1abea359b643310916a38aa0b0562" }

  it "has episodes" do
    expect(podcast.episodes.size).to eq 5

    expect(podcast.episodes.first.title).to eq "Клуб веселых академиков: Этнография"
  end
end
