# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/tags'

class TestTags < Minitest::Test
  def test_find_exact_match
    tags = Tags.new(
      tags: [
        { 'name' => '3.4.11' },
        { 'name' => '3.4.1' }
      ]
    )
    assert_equal(tags.find('3.4.1'), { 'name' => '3.4.1' })
    assert_nil(tags.find('3.4.10'))
  end

  def test_find_nearest_match
    tags = Tags.new(
      tags: [
        { 'name' => '3.4.1' },
        { 'name' => '3.4.11' }
      ]
    )
    assert_equal(tags.find('3.4'), { 'name' => '3.4.11' })
    assert_equal(tags.find('3'), { 'name' => '3.4.11' })
  end
end
