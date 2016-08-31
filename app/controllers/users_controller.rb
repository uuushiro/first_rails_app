class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :like_notes]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]

  def index
    @users = User.all
  end

  def show
    @notes = @user.notes
    @title = "投稿一覧"
  end

  def edit
  end

  def update
    file = params[:user][:image]
    @user.set_image(file)

    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報が更新されました'
    else
      render :edit
    end
  end

  def like_notes
    @title = "いいね！一覧"
    @notes = @user.like_notes
    render :show
  end

  def following
    @title = "JUSTONEしています"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "JUSTONEされています"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def matching
    @title = "マッチングしています"
    @user = User.find(params[:id])
    @users = @user.matchers
    render 'show_follow'
  end



  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end

    def correct_user
      user = User.find(params[:id])
      if !current_user?(user)
        redirect_to root_path, alert: '許可されていないページです'
      end
    end
end
