class UsersController < ApplicationController

  before_action :ensure_current_user, only: [:edit, :update]

  def index
    # 検索フォームで入力されたキーワードがパラメーター として渡されてparamsで受け取る
    @users = User.all.search(params[:search])
  end

  def show
    @user = User.find(params[:id])
  end
  
  def hide
    @user = User.find(params[:id])
    email = @user.email
    if email == 'guest@example.com'
      redirect_to root_path, notice: 'ゲストユーザーは編集・削除できません。'
    else
     #is_deletedカラムにフラグを立てる(defaultはfalse)
    @user.update(is_deleted: true)
    #ログアウトさせる
    reset_session
    redirect_to root_path, notice: "ありがとうございました。またのご利用を心よりお待ちしております。"

    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_current_user
    user = User.find(params[:id])
    if user != current_user
      redirect_to user_path(current_user)
    end
  end


end
