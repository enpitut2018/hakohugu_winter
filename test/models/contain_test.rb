require 'test_helper'

class ContainTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
      @template =  templates(:one)
      @question = questions(:one)
      @contain = Contain.new(template_id: @template.id, question_id: @question.id)
  end
  
  test "should be valid" do
    assert @contain.valid?
  end
end
