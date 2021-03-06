class SessionsController < ApplicationController

  def new; end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      # redirect_to root_path, notice: 'ログインに成功しました。'
      flash[:success] = 'ログインに成功しました。'
      redirect_to root_path
      # something_path => /something
      # something_url  => https://localhost:3000/somwthing
    else
      # render :new, alert: 'ログインに失敗しました。'
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_path
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end