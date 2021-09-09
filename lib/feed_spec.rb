require "feed"

RSpec.describe Feed do
  subject(:feed) { Feed.new podcast }

  let(:podcast) do
    double(
      :podcast,
      title: "Shinny new podcast",
      description: "Yet another podcast",
      address: "https://fake.web/podcast",
      language: "en",
      copyright: "Publisher One",
      author: "Ivan",
      owner_name: "Petr",
      owner_email: "petr@fake.web",
      image: "https://fake.web/image",
      episodes: [episode]
    )
  end

  let(:episode) do
    double(
      :episode,
      title: "Episode 1",
      description: "My very first episode.",
      enclosure_length: 1,
      enclosure_url: "https://fake.web/episode.mp3",
      guid: "1"
    )
  end

  it { expect(feed.xml.size).to be > 0 }
  it { puts feed.xml }
end
