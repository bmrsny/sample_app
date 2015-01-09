require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "JimBob Frank", email:"bmrsny@gmail.com")
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
end
