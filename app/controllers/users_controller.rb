class UsersController < ApplicationController

  def new
    # @userはUserというモデルのクラスによって、新しく作れたインスタンス(中身は空)
    @user = User.new
  end

  def create
    # @userはUserというモデルのクラスによって、新しく作れたインスタンス(中身はuser_paramsで取得した、name,email,password)
    @user =User.new(user_params)
    
    # @userをsave(データベースに登録する)したら、flashメッセージを表示させ、トップページにリダイレクトする
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to root_url
    #saveできなかったら、flashメッセージを表示させて、newアクションでおこるページ、つまり、新規ユーザ登録ページに飛ぶ
    else
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end
  
  private
  
  #Strong Parameter
  # name,email,passwordのデータを入力されて、送信されたデータをフィルタリングして精査するための設定
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
