# frozen_string_literal: true

class Tags
  class Fetcher
    def self.call
      JSON.parse(File.read(',/tags.json'))
    end
  end
end
