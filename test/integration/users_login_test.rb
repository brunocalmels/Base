require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "logueo con parametros correctos seguido de deslogueo" do
    get loguearse_path
    assert_template "sessions/new"
    post loguearse_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', loguearse_path, count: 0
    assert_select 'a[href=?]', desloguearse_path
    assert_select 'a[href=?]', user_path(@user)
    delete desloguearse_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    # Simulate a user clicking logout in a second window.
    delete desloguearse_path
    follow_redirect!
    assert_select 'a[href=?]', loguearse_path
    assert_select 'a[href=?]', desloguearse_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end

  test "logueo con parametros incorrectos" do
    get loguearse_path
    assert_template 'sessions/new'
    post loguearse_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login recordando" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login sin recordar" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

end
