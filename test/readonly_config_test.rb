require 'test_helper'

class ReadonlyConfigTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ReadonlyConfig::VERSION
  end

  def test_frozen_is_false_for_new_object
    rc = ReadonlyConfig.new
    assert(false == rc.frozen?)
  end

  def test_frozen_is_false_after_freeze_is_called
    rc = ReadonlyConfig.new
    rc.freeze
    assert(true == rc.frozen?)
  end

  def test_add_will_create_an_attribute_that_is_accessible_via_a_method_call
    rc = ReadonlyConfig.new
    rc.add(:your_name, "setec astronomy")
    assert(rc.your_name, "setec astronomy")
  end

  def test_add_will_raise_an_error_when_object_is_frozen
    rc = ReadonlyConfig.new
    rc.freeze
    assert_raises CannotAddToAFrozenConfigError do
      rc.add(:your_name, "setec astronomy")
    end
  end

  def test_can_read_attributes_when_frozen
    rc = ReadonlyConfig.new
    rc.add(:your_name, "setec astronomy")
    rc.freeze
    assert(rc.your_name, "setec astronomy")
  end
end

