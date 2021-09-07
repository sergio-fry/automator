require "podcast"

RSpec.describe Podcast do
  let(:podcast) { described_class.new(page) }
  let(:page) { double(:page) }
  it "has title" do
    expect(podcast.title).to eq "ХРУМ, или Сказочный детектив"
  end
  it "has episodes" do
  end
end
