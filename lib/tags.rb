# frozen_string_literal: true

require_relative './tags/fetcher'

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
      # HACK: Prepend "." to prevent "3.4.1" from matching '3.4.10'
      (tag['name'] + '.').start_with?(version + '.')
    }
  end
end
