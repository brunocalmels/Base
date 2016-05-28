module SessionsHelper
  
  # Usa la funcion de Rails para manejar sesiones temporales
  def log_in(user)
    session[:user_id] = user.id
  end

  # Devuelve el usuario, si esta logueado o tiene una cookie de sesion
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Devuelve true si el usuario esta logueado
  def logged_in?
    !current_user.nil?
  end

  # Desloguea al usuario
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Recuerda un usuario para una sesion futura
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Olvida una sesion persistente, borrando las cookies
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

end
