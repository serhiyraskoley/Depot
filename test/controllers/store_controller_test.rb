require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select 'nav a', minimum: 3 # assert that there are at least 3 <a> tags in the <nav> element
    assert_select 'main ul li', minimum: 3 # assert that there are at least 3 <li> tags in the <ul> element in the <main> element
    assert_select 'h2', 'Programming Ruby 1.9' # assert that there is an <h2> tag with the text "Programming Ruby 1.9"
    assert_select 'div', /\$[,\d]+\.\d\d/ # assert that there is a <div> tag with a price in the format $12,345.67
  end
end