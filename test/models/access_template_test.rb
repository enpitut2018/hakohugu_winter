require 'test_helper'

class AccessTemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
      @user =  users(:one)
      @template = templates(:one)
      @accesstemplate = AccessTemplate.new(user_id: @user.id, template_id: @template.id, level:1)
  end
  
  test "should be valid" do
      assert @accesstemplate.valid?
  end

end
