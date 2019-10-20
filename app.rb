# frozen_string_literal: true

require 'sinatra'
require 'json'
require_relative './lib/releases'

get %r{/(.+)\.(zip|tar\.gz)} do |version, ext|
  release = Releases.find_release(version)
  halt :not_found unless release

  url = case ext
        when 'zip' then release['zipball_url']
        when 'tar.gz' then release['tarball_url']
        end

  redirect url, 302
end
