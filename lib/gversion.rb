class Gversion
  include Comparable

  PATTERN = /^(?<major>0|[0-9][0-9]*)(\.(?<minor>0|[0-9][0-9]*))?(\.(?<revision>0|[0-9][0-9]*))?$/

  attr_reader :major, :minor, :revision

  def initialize(options)
    [:major, :minor, :revision].each do |field|
      validate_field(field, options[field])
      instance_variable_set("@#{field}", options[field] || 0)
    end
  end

  def self.parse(string)
    match = PATTERN.match(string)
    return nil unless match

    self[match[:major], match[:minor], match[:revision]]
  end

  def self.[](*array)
    new(major: array[0].to_i,
        minor: array[1].to_i,
        revision: array[2].to_i)
  end

  def self.parse!(string, _options = {})
    parse(string) || (fail ArgumentError, 'invalid version format')
  end

  def <=>(other)
    comparison = 0
    [:major, :minor, :revision].each do |field|
      comparison = send(field) <=> other.send(field)
      break if comparison != 0
    end

    comparison
  end

  def to_s
    @as_string ||= [major, minor, revision].join('.')
  end

  def to_f
    # Will be wrong float number if minor > 9
    @as_float ||= [major, minor].join('.').to_f
  end

  def self.greater_or_equal_than_version?(version, from_version)
    self.parse!(version) >= self.parse(from_version)
  end

  def self.lesser_than_version?(version, from_version)
    !self.greater_or_equal_than_version?(version, from_version)
  end

  def self.in_version_range?(version, from_version, to_version)
    v = self.parse!(version)
    min = self.parse!(from_version)
    max = self.parse!(to_version)

    v.between?(min, max)
  end

  private

  def validate_field(field, value)
    return unless value

    fail ArgumentError, "#{field} field must be an integer" unless value.is_a?(Integer)
  end
end
