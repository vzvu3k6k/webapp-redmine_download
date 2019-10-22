# frozen_string_literal: true

require 'net/http'
require 'active_support/cache'
require 'active_support/cache/redis_cache_store'

class Tags
  class Fetcher
    def self.call
      new.call
    end

    def call
      cache.fetch('tags') { fetch }
    end

    private

    def cache
      @cache ||= ActiveSupport::Cache::RedisCacheStore.new(
        url: ENV['REDIS_URL'],
        expires_in: 1.hour
      )
    end

    # FIXME: This method reads only the first page of tags.json
    def fetch
      response = Net::HTTP.new('api.github.com', 443).yield_self do |h|
        h.use_ssl = true
        h.get('/repos/redmine/redmine/tags', 'user-agent' => 'redmine-downloader')
      end
      response.value # raise an exception if status code is not 2xx
      JSON.parse(response.body)
    end
  end
end
