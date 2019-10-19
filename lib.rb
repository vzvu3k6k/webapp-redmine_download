# frozen_string_literal: true

def find_release(version, releases)
  releases.sort_by { |release|
    release['name'].split('.').map(&:to_i)
  }.reverse.find { |release|
    # HACK: Prepend "." to prevent "3.4.1" from matching '3.4.10'
    (release['name'] + '.').start_with?(version + '.')
  }
end

def releases
  JSON.parse(File.read(',/tags.json'))
end
