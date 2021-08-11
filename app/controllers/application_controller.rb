class ApplicationController < ActionController::Base
  # before_actionを定義することで全てのアクションが実行される前に、before_actionが実行される。
  before_action :authenticate_user!,except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end
  protected
  # 定義しないと下の記述が読み込まれない
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_image])
  end
end
