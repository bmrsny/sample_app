require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: '',
                                email: "user@invalid",
                                password: "1234",
                                password_confirmation: "123" }
  end
    assert_template 'users/new'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference "User.count", 1 do
      post_via_redirect users_path, user: {name: 'henry',
                              email: "user@gmail.com",
                              password: "foobar",
                              password_confirmation: "foobar"}
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end
