require_relative('../manager_prompt')
require('minitest/autorun')
require('minitest/rg')

class TestManagerPrompt < Minitest::Test

  def setup
    @manager_prompt = ManagerPrompt.new('how are you?', [[1,'fine'], [2, 'outstanding']])
  end

  def test_prompt_has_query
    assert_equal('how are you?', @manager_prompt.query)
  end

  def test_prompt_has_options_hash
    assert_equal('outstanding', @manager_prompt.options_list[1][1])
  end

end