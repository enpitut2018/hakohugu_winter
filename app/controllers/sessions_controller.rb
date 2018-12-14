class SessionsController < ApplicationController
  def new
  	render :layout => nil
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      redirect_to documents_path
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'eメールまたはパスワードが違います。'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to '/'
  end

end
