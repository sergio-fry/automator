require "fake/internet"

module Fake
  RSpec.describe Internet do
    subject(:internet) { described_class.new }

    it "get page content" do
      resp = internet.read("https://www.deti.fm/program_child/uid/114343")
      expect(resp.body.size).to be > 0
      expect(resp.code).to eq 200
    end

    it "get nothing when no page exists" do
      resp = internet.read("https://foo.bar/page-1")
      expect(resp.body).to eq ""
      expect(resp.code).to eq 404
    end
  end
end
