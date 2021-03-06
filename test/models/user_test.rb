require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "JimBob Frank", email:"bmrsny@gmail.com",
                      password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'should be invalid without a name' do
    @user.name = " "
    assert_not @user.valid?
  end

  test 'should be invalid without a email' do
    @user.email = nil
    assert_not @user.valid?
  end

  test 'should not have a name longer than 50 chars' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'should not have an email longer than 255 chars' do

    @user.email = 'b' * 256
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_email_addresses = %w[bdfdmrsny@gmail.comm USER@foo.COM A_Us-ER@foo.bar.org
                              first.last@foo.jp alice+bob@baz.cn]
    valid_email_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email should reject invalid addresses' do
    invalid_email_addresses = %w[user@example,com user_at_foo.org user.name@example
                                .foo@boarfoo@bar_baz.com foo@bar+baz.com]
    invalid_email_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email address should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test 'should be saved as lowercase' do
    mixed_case_email = 'Foo@Email.com'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

	test 'should return false for authenticated? if user digest is nil' do
		assert_not @user.authenticated?('')
	end
end
