# frozen_string_literal: true

require 'sinatra'
require 'json'
require_relative './lib'

get %r{/(.+)\.(zip|tar\.gz)} do |version, ext|
  release = find_release(version, releases)
  halt :not_found unless release

  url = case ext
        when 'zip' then release['zipball_url']
        when 'tar.gz' then release['tarball_url']
        end

  redirect url, 302
end
