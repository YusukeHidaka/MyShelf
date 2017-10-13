class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
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
end
