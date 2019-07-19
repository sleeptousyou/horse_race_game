class PurchaseController < ApplicationController
  before_action :check_login_user
  def record
    @money=Money.find_by(user_id: @current_user.id,prize_number:1)
    @number=0
    @prices=[]
    params[:used].each do |u|
        @prices.push(u['name'].to_i)
    end

    if @prices.sum % 100 != 0
        flash[:notice]='100円未満の金額が入力されています'
        redirect_to('/races/play')
    elsif @prices.sum <= @money.unused
       @money.unused = @money.unused - @prices.sum
       @money.used = @money.used + @prices.sum
       @money.save
       @selections=Selection.where(user_id: @current_user.id)
       @selections.each do |select|
        Purchase.create(
          user_id: select.user_id,
          prize_number: select.prize_number,
          win: select.win,
          quinella: select.quinella,
          trio: select.trio,
          betting_ticket: select.betting_ticket,
          price: @prices[@number],
          list_id: @list.id
        )
        @number=@number+1
       end
       flash[:notice]='購入しました'
       Purchase.where(user_id: @current_user.id,price: 0).destroy_all
       Selection.where(user_id: @current_user.id).destroy_all
       @ballot=Ballot.find_by(user_id: @current_user.id,list_id: @list.id)
       if @ballot==nil
        Ballot.create(user_id: @current_user.id,list_id: @list.id)
       end
       redirect_to('/purchase/show')
    elsif
      flash[:notice]='購入限度額を超えています'
      redirect_to('/races/play')
    end
  end  

  
  def show
    @purchase=Purchase.where(user_id: @current_user.id)
    @count=1
  end

  def index
    @ballots=Ballot.where(list_id: @list.id)
  end

  def recovery
    @users=User.all
    @users.each do |user|
      @mark=Mark.find_by(user_id:user.id,year:@list.year)
      @recoveries=Recovery.where(user_id: user.id,year:@list.year)
      if @recoveries.sum(:sum_get)!=0 
        @total_get=@recoveries.sum(:sum_get)
        @recovery_rate=@recoveries.sum(:sum_get)/@recoveries.sum(:sum_price)*100
        @hit_ratio=@recoveries.sum(:hit)/@recoveries.count(:hit)*100
        @most_high_get=@recoveries.maximum(:sum_get)
        if @mark
          @mark.total_get=@total_get
          @mark.recovery_rate=@recovery_rate
          @mark.hit_ratio=@hit_ratio
          @mark.most_high_get=@most_high_get
          @mark.save
        else
          @mark=Mark.new(
            user_id: user.id,
            year: @list.year,
            total_get: @total_get,
            recovery_rate: @recovery_rate,
            hit_ratio: @hit_ratio,
            most_high_get: @most_high_get
              )
          @mark.save
        end
      end
    end
  end

  def recovery_form
    if params[:id]=="1"
      @marks=Mark.all.order("recovery_rate Desc")
    elsif params[:id]=="2"
      @marks=Mark.all.order("hit_ratio Desc")
    elsif params[:id]=="3"
      @marks=Mark.all.order("total_get Desc")
    else
      @marks=Mark.all.order("most_high_get Desc")
    end
  end
  
end
