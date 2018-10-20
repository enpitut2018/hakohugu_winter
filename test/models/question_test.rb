require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
      @question = Question.new(qtext: "Example Question")
  end
  
  test "should be valid" do
    assert @question.valid?
  end

  test "name should be present" do
      @question.qtext = "     "
      assert_not @question.valid?
  end
  test "name should not be too long" do
      @question.qtext = "a" * 101
      assert_not @question.valid?
  end


end
