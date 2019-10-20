# frozen_string_literal: true

require 'minitest/autorun'
require 'rack/test'
require_relative '../app'

class TestApp < Minitest::Test
  include Rack::Test::Methods

  def app
    App.new.tap do |app|
      app.settings.set :tags, Tags.new(
        tags: [
          {
            'name' => '4.0.5',
            'tarball_url' => 'https://api.github.com/repos/redmine/redmine/tarball/4.0.5'
          }
        ]
      )
    end
  end

  def test_redirect
    get '/4.0.tar.gz'
    assert last_response.redirect?
    assert_equal last_response.location, 'https://api.github.com/repos/redmine/redmine/tarball/4.0.5'
  end

  def test_unsupported_ext
    get '/4.0.rar'
    assert last_response.not_found?
  end

  def test_non_existent_version
    get '/10.0.tar.gz'
    assert last_response.not_found?
  end
end
