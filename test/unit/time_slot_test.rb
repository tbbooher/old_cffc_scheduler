require 'test_helper'

class TimeSlotTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert TimeSlot.new.valid?
  end
end
