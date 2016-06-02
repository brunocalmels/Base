# -*- coding: utf-8 -*-
class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    @greeting = "Hola"
    mail to: user.email, subject: "Activación de tu cuenta"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @greeting = "Hola"
    @user = user
    mail to: user.email, subject: "Reseteo de contraseña"
  end
end
