require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: 'Bob', email: 'bob@bob.com', password: "APassword", password_confirmation: "APassword")
  end

  test "should be valid" do
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
    valid_addresses = %w[user@example.com User@u.COM A_u.s-e+r@u.cn b@some.net new@user.org another@blah.co]
    valid_addresses.each do |email_address|
      @user.email = email_address
      assert @user.valid?, "#{email_address} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example user_at_foo.org new@new_site.com extra@new+site.com]
    invalid_addresses.each do |email_address|
      @user.email = email_address
      assert_not @user.valid?, "#{email_address} should not be valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
