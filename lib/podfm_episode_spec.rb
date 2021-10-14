require "podfm_episode"
require "fake/internet"

RSpec.describe PodfmEpisode do
  subject(:episode) { described_class.new "https://podfm.ru/episodes/klub-veselyh-akademikov-etnografiya/", internet: Fake::Internet.new }
  it { expect(episode.title).to eq "Клуб веселых академиков: Этнография" }
  it { expect(episode.image).to eq "https://doodleipsum.com/3000x3000/abstract?i=f8b1abea359b643310916a38aa0b0562" }
  it { expect(episode.audio).to eq "https://backend.soundstream.media/mp3/70893ba48fb5e06f4ee0d42e26b959ad/high.mp3" }
end
