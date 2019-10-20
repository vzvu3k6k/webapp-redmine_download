# frozen_string_literal: true

require 'sinatra'
require 'json'
require_relative './lib/tags'

get %r{/(.+)\.(zip|tar\.gz)} do |version, ext|
  tag = Tags.find(version)
  halt :not_found unless tag

  url = case ext
        when 'zip' then tag['zipball_url']
        when 'tar.gz' then tag['tarball_url']
        end

  redirect url, 302
end
