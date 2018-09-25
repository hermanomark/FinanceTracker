require 'test_helper'

class FinancetrackersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get financetrackers_index_url
    assert_response :success
  end

end
