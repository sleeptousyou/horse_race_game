class CommentsController < ApplicationController
  before_action :check_login_user

  def index
    @boards=Board.where(list_id: @list.id).order("created_at desc")
  end

  def text
  end

  def transmission
    @board=Board.new(user_id: @current_user.id,list_id:@list.id,comment: params[:comment])
    if @board.save
      flash[:notice]='投稿しました'
      redirect_to('/comments/index')
    else
      flash[:notice]='空欄では投稿できません'
      redirect_to('/comments/index')
    end
  end
end
