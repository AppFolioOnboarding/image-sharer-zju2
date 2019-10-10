require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'test view content' do
    get root_path
    assert_response :ok
  end
end
