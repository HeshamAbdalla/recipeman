require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @user = User.create(chefname:"boob", email:"bob@example.com")
    @recipe = @user.recipes.build(name:"chicken parm", summary:"this is the best chicken parm recipe ever",
                                                      description:"Add some vegetables, add cooking oil, cook for at least one hour at low heat, or use the oven for cooking")
  end
  test "user_id should be present" do
    @recipe.user_id = nil
    assert_not @recipe.valid?
  end
  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  test "name length should not be too long" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end
  test "name length should not be too short" do
    @recipe.name = "aa"
    assert_not @recipe.valid?
  end
  test "summary should be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?

  end
  test "summary should not be too long" do
    @recipe.summary = "a" * 101
    assert_not @recipe.valid?
  end
  test "summary should not be too short" do
    @recipe.summary = "aaa" * 10
    assert_not @recipe.valid?
  end
  test "description must be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  test "description should not be too short" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  test "description should not be too long" do
    @recipe.description = "a" * 101
    assert_not @recipe.valid?
  end
end
