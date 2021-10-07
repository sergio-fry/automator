# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "http"
gem "nokogiri"
gem "puma"
gem "roda"
gem "veils"

group :development do
  gem "standard"
  gem "rake"
  gem "solargraph"
end

group :test do
  gem "rspec"
  gem "simplecov", require: false
end
