require 'minitest/autorun'
require 'version'

class VersionTest < Minitest::Test
  def test_invalid_arguments
    assert_raises do
      Version.in_version_range?
    end
  end

  def test_greater_or_equal_than_version
    assert Version.greater_or_equal_than_version?('6.17.0', '6.16.1')
  end

  def test_lesser_than_version
    assert Version.lesser_than_version?('6.16.0', '6.17.0')
  end

  def test_in_version_range
    assert Version.in_version_range?('6.16.0', '6.15.0', '6.17.0')
  end
end
