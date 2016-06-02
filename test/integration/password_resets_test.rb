# -*- coding: utf-8 -*-
require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  test "Reseteo de contraseña con todo" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Email inválido
    post password_resets_path, password_reset: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Email válido
    post password_resets_path, password_reset: { email: @user.email }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Formulario de reset
    user = assigns(:user)
    # Email incorrecto
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
    # Usuario inactivo
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    # Token inválido, email correcto
    get edit_password_reset_path("token incorrectoy", email: user.email)
    assert_redirected_to root_url
    # Token e emails válidos
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    # Contraseña y confirmación inválidos
    patch password_reset_path(user.reset_token), email: user.email,
                                                  user: { password: "foobar",
                                                          password_confirmation: "foobaz"}
    assert_select "div#error_explanation"
    # Contraseña vacía
    patch password_reset_path(user.reset_token), email: user.email,
                                                  user: { password: "",
                                                          password_confirmation: "foobaz"}
    assert_select "div#error_explanation"
    # Contraseña y confirmación válidas
    patch password_reset_path(user.reset_token), email: user.email,
                                                  user: { password: "foobar",
                                                          password_confirmation: "foobar"}
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end

end
