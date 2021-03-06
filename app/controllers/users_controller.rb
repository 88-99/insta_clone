class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[ new create edit update ]
  before_action :ensure_correct_user, only: %i[ edit update ]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id), notice: "登録が完了しました！"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィールを更新しました！"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile_picture, :image_cashe, :user_id)
  end

  def ensure_correct_user
    user = User.find(params[:id])
    if user.id != current_user.id
      redirect_to blogs_path, notice: "権限がありません"
    end
  end
end
