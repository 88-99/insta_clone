class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required
  before_action :ensure_correct_user, only: %i[ edit update destroy ]

  private
  def login_required
    redirect_to new_session_path unless current_user
  end

  def ensure_correct_user
    @current_user = current_user
    if @current_user.id != params[:id].to_i
      redirect_to blogs_path, notice: "権限がありません"
    end
  end
end
