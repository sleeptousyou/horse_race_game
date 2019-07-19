class ApplicationController < ActionController::Base
    before_action :authenticate_users
    before_action :find_thisweek
    before_action :deadline,{only:[:bet,:win ,:quinella ,:trio,:play]}


    def authenticate_users
        @current_user = User.find_by(id: session[:user_id])
    end

    def find_thisweek
        @list=List.find_by(thisweek: true)
    end

    def check_login_user
        if session[:user_id]==nil
            flash[:notice]='ログインしていません'
            redirect_to('/main/top')
        end
    end

    def deadline
        if @list.deadline < Time.now
            flash[:notice]='投票可能時間を過ぎています。'
            redirect_to("/main/top")
        end
    end

    
    
end
