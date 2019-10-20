# frozen_string_literal: true

require 'minitest/autorun'
require_relative './lib'

class TestFindRelease < Minitest::Test
  def test_exact_match
    releases = [
      { 'name' => '3.4.11' },
      { 'name' => '3.4.1' }
    ]
    assert_equal(find_release('3.4.1', releases), { 'name' => '3.4.1' })
    assert_nil(find_release('3.4.10', releases))
  end

  def test_nearest_match
    releases = [
      { 'name' => '3.4.1' },
      { 'name' => '3.4.11' }
    ]

    assert_equal(find_release('3.4', releases), { 'name' => '3.4.11' })
    assert_equal(find_release('3', releases), { 'name' => '3.4.11' })
  end
end
