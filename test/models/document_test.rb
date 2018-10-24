require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
      @user =  users(:one)
      @template = templates(:one)
      @document = Document.new(title: "Sample", user_id: @user.id, template_id: @template.id, scope:1)
  end
  
  test "should be valid" do
    assert @document.valid?
  end

  test "user id should be present" do
      @document.user_id = nil
      assert_not @document.valid?
  end

  test "title should be present" do
    @document.title = "   "
    assert_not @document.valid?
  end

  test "title should be at most 50 characters" do
    @document.title = "a" * 51
    assert_not @document.valid?
  end

end
