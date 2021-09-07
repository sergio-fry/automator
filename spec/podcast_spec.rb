require "support/fixture"
require "podcast"

RSpec.describe Podcast do
  let(:podcast) { described_class.new(page) }
  let(:page) { Support::Fixture.new("podcast/podcast.html").content }

  it "has title" do
    expect(podcast.title).to eq "ХРУМ, или Сказочный детектив"
  end
  it "has episodes" do
  end
end
