require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
      @user =  users(:one)
      @category = categories(:one)
      @template = Template.new(title: "Sample", user_id: @user.id, category_id: @category.id, scope:1)
  end
  
  test "should be valid" do
    assert @template.valid?
  end

  test "user id should be present" do
      @template.user_id = nil
      assert_not @template.valid?
  end

  test "title should be present" do
      @template.title = "   "
      assert_not @template.valid?
  end

  test "name should be at most 50 characters" do
      @template.title = "a" * 51
      assert_not @template.valid?
  end
end
