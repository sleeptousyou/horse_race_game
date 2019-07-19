class UsersController < ApplicationController
before_action :check_login_user,{only:[:show,:index]}

  def new
    @user=User.new
  end

  def index
    @users=User.all
  end

  def login_form
  end

  def login
    @user=User.find_by(email: params[:email],password: params[:password])
    if @user
      flash[:notice]='ログインしました'
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}/show")
    else
      flash[:notice]='email又はpasswordが間違っています'
      render('/users/login_form')
    end
  end

  def create
    @user=User.new(name: params[:name],email: params[:email], password: params[:password])
    if @user.save
      Money.create(user_id: @user.id,unused: 3000,used: 0,prize_number: 1)
      flash[:notice] = '新規登録しました'
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}/show")
    else
      render('/users/new')
    end
  end

  def logout
    session[:user_id]=nil
    flash[:notice]='ログアウトしました'
    redirect_to('/users/login_form')
  end

  def show
    @user=User.find_by(id: params[:id]) 
    @money=Money.find_by(user_id: @user.id)
    @purchases=Purchase.where(user_id: @user.id)
  end

  def mail_check
    @question=Question.new(email: params[:email],document: params[:document])
    if @question.save
       flash[:notice]='メッセージを送信しました'
       redirect_to('/main/top')
    else
      flash[:notice]='メッセージの送信に失敗しました'
      redirect_to('/users/mail')
    end
  end
end
