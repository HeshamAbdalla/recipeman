require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(chefname:" ", email:"example@test.com")
  end
  test "User should be valid" do
    assert @user.valid?
  end
  test "Chef name should be present" do
    @user.chefname = " "
    assert_not @user.valid?
  end
  test "Chef name should not be too long" do
    @user.chefname = "a" * 101
    assert_not @user.valid?
  end
  test "Chef name should not be too short" do
    @user.chefname = "a"
    assert_not @user.valid?
  end
  test "Chef email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
  test "Chef email should not be too long" do
    @user.email = "a" * 1001 + "@example.com"
    assert_not @user.valid?
  end
  test "Chef email should be unique" do
    dup_chef = @user.dup
    dup_chef.email = @user.email.upcase
    @user.save
    assert_not dup_chef.valid?
    assert_not @user.valid?
  end
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com frist.last@eem.au laura+joe@monk.cm]
    valid_addresses.each do |va|
      @user.email = va
      assert @user.valid?, '#{va.inspect} should be valid'
    end
  end
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_ateeee.org user.name@example. eee@i_am_.com foo@ee+aar.com]
    invalid_addresses.each do |ia|
      @user.email = ia
      assert_not @user.valid?, '#{ia.inspect} should be invalid'
    end
  end
end
