class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_login, if: :use_before_action?
  before_action :set_request_from
  # before_action :authenticate_user! => users/sign_inに遷移してしまうので、変えたい。もしくは、そっちにwelcome移すか？
  # https://qiita.com/mosa_siru/items/8dc8bb098f1dea6ffb5d
  # 試したけどエラー出る。

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    authenticated_root_path
  end
  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
    unauthenticated_root_path
  end

  def check_login
    if !user_signed_in?
      redirect_to unauthenticated_root_path
    end
  end

  private

  def use_before_action?
    false
  end

  # どこのページからリクエストが来たか保存しておく
  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    # 現在のURLを保存しておく
    session[:request_from] = request.original_url
  end

  # 前の画面に戻る
  def return_back
    if request.referer
      redirect_to :back and return true
    elsif @request_from
      redirect_to @request_from and return true
    end
  end
end
