
require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get inicio" do
    get :inicio
    assert_response :success
    assert_select "title", "Business Intelligence | Macher IT"
  end

  test "should get form_visita" do
    get :form_visita
    assert_response :success
    assert_select "title", "Registrar una visita | Macher IT"
  end

end
