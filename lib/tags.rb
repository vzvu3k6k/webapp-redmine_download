# frozen_string_literal: true

require_relative './tags/fetcher'

using Module.new {
  refine Array do
    def start_with?(other)
      other.zip(self).all? { |a, b| a == b }
    end
  end
}

class Tags
  def self.find(version)
    new.find(version)
  end

  def initialize(fetcher = Tags::Fetcher)
    @fetcher = fetcher
  end

  def tags
    @fetcher.call
  end

  def find(version)
    tags.sort_by { |tag|
      tag['name'].split('.').map(&:to_i)
    }.reverse.find { |tag|
      tag['name'].split('.').start_with?(version.split('.'))
    }
  end
end
