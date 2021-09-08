require "fake_internet"

RSpec.describe FakeInternet do
  subject(:internet) { described_class.new }

  it "get page content" do
    expect(internet.read("https://www.deti.fm/program_child/uid/114343").size).to be > 0
  end

  it "get nothing when no page exists" do
    expect(internet.read("https://foo.bar/page-1")).to eq ""
  end
end
