require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/inicio'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", "http://macherit.com", count: 2
    assert_select "a[href=?]", ayuda_path, count: 2
    assert_select "a[href=?]", visita_path
    assert_select "a[href=?]", cliente_path
  end

end
