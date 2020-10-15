require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup, associated errors and render action' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         email: 'user@invalid',
                                         password: 'foo',
                                         password_confirmation: 'foobar' } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid signup, redirect, flash and success message' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Tracey Huang',
                                         email: 'th@mail.com',
                                         password: 'thspassword',
                                         password_confirmation: 'thspassword' } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty? # assert_not_empty flash; refute flash.empty; refute_empty flash 
    assert_select 'div.alert-success'
  end
end
