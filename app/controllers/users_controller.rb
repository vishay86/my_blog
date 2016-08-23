class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = 'Welcome! Sign Up was successful'
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(users_params)
      flash[:success] = 'User info successfully updated'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end

  private

  def users_params
    params.require(:user).permit(:username , :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end