require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: 'Bob', email: 'bob@bob.com')
  end

  test "Shoudl be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "b" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.name = "b" * 256
    assert_not @user.valid?
  end

  test "email address should be valid" do
    valid_addresses = %w[user@example.com User@u.com A_u.s-e+r@u.cn b@some.net new@user.org ]
  end

end
