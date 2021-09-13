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
      title: "Title"
    )
  end

  let(:storage) { MemoryStorage.new }

  before { storage.save_podcast podcast }

  let(:persisted_podcast) { PersistedPodcast.new(podcast.guid, storage: storage) }

  it { expect(persisted_podcast.title).to eq podcast.title }
  it { expect(persisted_podcast.image).to eq podcast.image }
  it { expect(persisted_podcast.language).to eq podcast.language }
  it { expect(persisted_podcast.copyright).to eq podcast.copyright }
  it { expect(persisted_podcast.author).to eq podcast.author }
  it { expect(persisted_podcast.description).to eq podcast.description }
  it { expect(persisted_podcast.owner_name).to eq podcast.owner_name }
  it { expect(persisted_podcast.owner_email).to eq podcast.owner_email }

  xit { expect(persisted_podcast.episodes).to eq podcast.episodes }
end
