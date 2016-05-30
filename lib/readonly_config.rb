require "readonly_config/version"

class CannotAddToAFrozenConfigError < StandardError; end

class ReadonlyConfig
  def method_missing(method_sym, *arguments, &block)
    @attributes[method_sym] || super
  end

  def initialize
    @attributes = {}
    @frozen = false
  end

  def frozen?
    @frozen
  end

  def freeze
    @frozen = true
  end

  def add(key, value)
    raise CannotAddToAFrozenConfigError if frozen?
    @attributes[key] = value
  end
end

