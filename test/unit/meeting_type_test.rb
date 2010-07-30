require 'test_helper'

class MeetingTypeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert MeetingType.new.valid?
  end
end
