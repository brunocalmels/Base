require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test 'informacion de registro invalida' do
    get registrarse_path
    assert_no_difference 'User.count' do
      post users_path user: { name: "",
                              email: "user@invalid",
                              password: "foo",
                              password_confirmation: "bar"
      }
      assert_template 'users/new'
    end
  end

  test "registro de usuario valido" do
    get registrarse_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Ejemplo ejemplar",
                                            email: "mail@ejemplar.com", 
                                            password: 'foobar',
                                            password_confirmation: 'foobar'
      }
      assert_template 'users/show'
      assert is_logged_in?
    end
  end

end
