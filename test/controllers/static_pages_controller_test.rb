
require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get inicio" do
    get :inicio
    assert_response :success
    assert_select "title", "Business Intelligence"
  end

  test "should get form_visita" do
    get :form_visita
    assert_response :success
    assert_select "title", "Registrar una visita | Business Intelligence"
  end

  test "should get ayuda" do
    get :ayuda
    assert_response :success
    assert_select "title", "Ayuda | Business Intelligence"
  end


  test "should get cliente" do
    get :form_cliente
    assert_response :success
    assert_select "title", "Registrar un cliente | Business Intelligence"
  end

end
