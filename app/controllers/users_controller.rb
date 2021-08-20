class UsersController < ApplicationController

  def index
    # 検索フォームで入力されたキーワードがパラメーター として渡されてparamsで受け取る
    @users = User.all.search(params[:search])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id), notice: "プロフィールを更新しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
