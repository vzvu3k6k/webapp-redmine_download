# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/releases'

class TestReleases < Minitest::Test
  def test_find_release_exact_match
    releases = Releases.new(
      releases: [
        { 'name' => '3.4.11' },
        { 'name' => '3.4.1' }
      ]
    )
    assert_equal(releases.find_release('3.4.1'), { 'name' => '3.4.1' })
    assert_nil(releases.find_release('3.4.10'))
  end

  def test_find_release_nearest_match
    releases = Releases.new(
      releases: [
        { 'name' => '3.4.1' },
        { 'name' => '3.4.11' }
      ]
    )
    assert_equal(releases.find_release('3.4'), { 'name' => '3.4.11' })
    assert_equal(releases.find_release('3'), { 'name' => '3.4.11' })
  end
end
