require "memory_storage"
require "persisted_podcast"

RSpec.describe PersistedPodcast do
  let(:podcast) do
    double(
      :podcast,
      guid: 1,
      author: "Ivan",
      copyright: "Copy(c)",
      description: "DESC",
      image: "https://fake.web/image",
      language: "en",
      owner_email: "petr@fake.web",
      owner_name: "Petr",
      title: "Title",
      episodes: episodes
    )
  end

  let(:episodes) { [episode] }
  let(:episode) { double(:episode) }

  let(:persisted_podcast) { PersistedPodcast.new(podcast, storage: MemoryStorage.new) }
  before { persisted_podcast.save }

  it { expect(persisted_podcast.title).to eq podcast.title }
  it { expect(persisted_podcast.image).to eq podcast.image }
  it { expect(persisted_podcast.language).to eq podcast.language }
  it { expect(persisted_podcast.copyright).to eq podcast.copyright }
  it { expect(persisted_podcast.author).to eq podcast.author }
  it { expect(persisted_podcast.description).to eq podcast.description }
  it { expect(persisted_podcast.owner_name).to eq podcast.owner_name }
  it { expect(persisted_podcast.owner_email).to eq podcast.owner_email }

  describe "persisted_episode" do
    let(:persisted_episode) { persisted_podcast.episodes.first }
    let(:episode) { double(:episode, title: "Episode") }
    it { expect(persisted_episode.title).to eq episode.title }
  end
end
