# frozen_string_literal: true

require 'sinatra/base'
require 'json'
require_relative './lib/tags'

class App < Sinatra::Base
  set :markdown, layout_engine: :slim

  configure do
    set :tags, Tags.new
  end

  get '/' do
    markdown :index
  end

  get %r{/(.+)\.(zip|tar\.gz)} do |version, ext|
    tag = settings.tags.find(version)
    halt 404 unless tag

    url = case ext
          when 'zip' then tag['zipball_url']
          when 'tar.gz' then tag['tarball_url']
          end

    redirect url, 302
  end
end
