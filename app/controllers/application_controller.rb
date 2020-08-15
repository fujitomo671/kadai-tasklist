class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private 
  # メソッド名を変える
  def restrict_user
    redirect_to sessions_new_path unless logged_in?
  end
  
  # TODO, ログインしている場合はログイン関連のページでこちらを実行させる
  def deny_logedinuser
    redirect_to root_path if logged_in?
  end
end
