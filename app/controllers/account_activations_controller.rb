# -*- coding: utf-8 -*-
class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Tu cuenta fue activada."
      redirect_to user
    else
      flash[:danger] = "Enlace de activación inválido. Si creés que esto es un error, avisanos."
      redirect_to root_url
    end
  end
end
