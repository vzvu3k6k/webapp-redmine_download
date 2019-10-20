# frozen_string_literal: true

class Releases
  def self.find_release(version)
    new.find_release(version)
  end

  attr_reader :releases

  def initialize(releases: JSON.parse(File.read(',/tags.json')))
    @releases = releases
  end

  def find_release(version)
    releases.sort_by { |release|
      release['name'].split('.').map(&:to_i)
    }.reverse.find { |release|
      # HACK: Prepend "." to prevent "3.4.1" from matching '3.4.10'
      (release['name'] + '.').start_with?(version + '.')
    }
  end
end
