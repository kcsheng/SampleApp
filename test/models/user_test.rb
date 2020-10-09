require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: 'Michael Hartl', 
      email: 'mh@mail.com', 
      password: 'foobar', 
      password_confirmation: 'foobar'
    )
  end
  test 'user should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '    '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'name should be less than 50' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should be less than 255' do
    @user.email = 'a' * 256
    assert_not @user.valid?
  end

  test 'validation should recognize valid emails' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} failed the test."
    end
  end

  test 'validation should recognize invalid emails' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} failed the test"
    end
  end

  test 'email address should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email address should be saved in lowercase' do
    @user.email = 'Mh@maiL.COM'
    @user.save
    assert_equal @user.email.downcase, @user.reload.email 
  end

  test 'password should be present and not blank' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should have a minimum length of 6' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
end