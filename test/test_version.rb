require 'minitest/autorun'
require 'gversion'

class GversionTest < Minitest::Test
  def test_invalid_arguments
    assert_raises do
      Gversion.in_version_range?
    end
  end

  def test_greater_or_equal_than_version
    assert Gversion.greater_or_equal_than_version?('6.17.0', '6.16.1')
  end

  def test_lesser_than_version
    assert Gversion.lesser_than_version?('6.16.0', '6.17.0')
  end

  def test_in_version_range
    assert Gversion.in_version_range?('6.16.0', '6.15.0', '6.17.0')
  end
end
