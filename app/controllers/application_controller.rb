class ApplicationController < ActionController::Base
  # アクセス権限(ログインしていない場合ユーザーが使える機能を制限)
  # before_actionを定義することで全てのアクションが実行される前に、before_actionが実行される。
  before_action :authenticate_user!,except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 新規登録後/ログイン後をuser/showに遷移させる
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_image])
  end
end
