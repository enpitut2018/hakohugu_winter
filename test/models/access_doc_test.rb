require 'test_helper'

class AccessDocTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
      @user =  users(:one)
      @document = documents(:one)
      @accessdoc = AccessDoc.new(user_id: @user.id, document_id: @document.id, level:1)
  end
  
  test "should be valid" do
      assert @accessdoc.valid?
  end
end
