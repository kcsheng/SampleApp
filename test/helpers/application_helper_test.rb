require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'tile helper' do
    assert_equal title, "KC Sheng's Sample App"
    assert_equal title('Help'), "Help | KC Sheng's Sample App"
    assert_equal title('Sign up'), "Sign up | KC Sheng's Sample App"
  end
end