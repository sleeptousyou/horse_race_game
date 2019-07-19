class AdminController < ApplicationController
  before_action :check_login_user


  def entry
  end

  def record
    @horse=Horse.new(
      race_name: params[:race_name],
      horse_number: params[:horce_number].to_i,
      gate_number: params[:gate_number].to_i,
      horse_name: params[:horse_name],
      sex: params[:sex],
      year: params[:year].to_i,
      rider: params[:rider],
      prize_number: params[:prize_number].to_i,
      list_id: @list.id
      )

    if @horse.save
      redirect_to('/races/bet')
    else
      render('/admin/entry')
    end
  end

  def list1
  end

  def list2
    List.update_all(thisweek: false)
    @lists=List.new(race_name: params[:name],year: params[:year],thisweek:true,
    deadline: params[:deadline])
    @lists.save
    redirect_to('/races/bet')
  end

  def rank_record
    @rank=Rank.find_by(list_id: @list.id)
    if @rank==nil
      @horse1=Horse.find_by(list_id: @list.id,horse_number: params[:win].to_i)
      @horse2=Horse.find_by(list_id: @list.id,horse_number: params[:second].to_i)
      @reverse_gate=[@horse1.gate_number,@horse2.gate_number]
      @asc_gate=@reverse_gate.sort
      @rank=Rank.new(
        list_id: @list.id,
        win: params[:win].to_i,
        second: params[:second].to_i,
        third: params[:third].to_i,
        gate1: @asc_gate[0],
        gate2: @asc_gate[1]
      )
      if @rank.save
        flash[:notice]='登録されました'
        redirect_to('/admin/rank')
      else
        render('/admin/rank')
      end
    else
      @horse1=Horse.find_by(list_id: @list.id,horse_number: params[:win].to_i)
      @horse2=Horse.find_by(list_id: @list.id,horse_number: params[:second].to_i)
      @reverse_gate=[@horse1.gate_number,@horse2.gate_number]
      @asc_gate=@reverse_gate.sort
      @rank=Rank.update(
        list_id: @list.id,
        win: params[:win].to_i,
        second: params[:second].to_i,
        third: params[:third].to_i,
        gate1: @asc_gate[0],
        gate2: @asc_gate[1]
      )
      flash[:notice]='更新されました'
      redirect_to('/admin/rank')
    end
  end

  def dividend_record
    @dividend=Dividend.new(
      list_id:@list.id,
      win:params[:win].to_i,
      place1:params[:place1].to_i,
      place2:params[:place2].to_i,
      place3:params[:place3].to_i,
      bracket_quinella:params[:bracket_quinella].to_i,
      quinella:params[:quinella].to_i,
      exacta:params[:exacta].to_i,
      quinella_place1:params[:quinella_place1].to_i,
      quinella_place2:params[:quinella_place2].to_i,
      quinella_place3:params[:quinella_place3].to_i,
      trio:params[:trio].to_i,
      trifecta:params[:trifecta].to_i
      )
    if @dividend.save
      flash[:notice]='登録されました'
      redirect_to('/admin/dividend')
    else
      render('/admin/dividend')
    end
  end

  def calculate
  end

  def calculate2
    @dividend=Dividend.find_by(list_id: @list.id)
    @rank=Rank.find_by(list_id: @list.id)
    @wide1=[@rank.win,@rank.second]
    @wide1=@wide1.sort!
    @wide2=[@rank.win,@rank.third]
    @wide2=@wide2.sort!
    @wide3=[@rank.second,@rank.third]
    @wide3=@wide3.sort!  
    @purchases=Purchase.where(list_id: @list.id)
    if @purchases != nil
      @purchases.each do |purchase|
        if purchase.betting_ticket==1 && purchase.win == @rank.win
          purchase.get=purchase.price*@dividend.win/100
          purchase.save
        elsif purchase.betting_ticket==2 && purchase.win == @rank.win
          purchase.get=purchase.price*@dividend.place1/100
          purchase.save
        elsif purchase.betting_ticket==2 && purchase.win == @rank.second
          purchase.get=purchase.price*@dividend.place2/100
          purchase.save
        elsif purchase.betting_ticket==2 && purchase.win == @rank.third
          purchase.get=purchase.price*@dividend.place3/100
          purchase.save  
        elsif purchase.betting_ticket==3 && purchase.win == @rank.gate1 && purchase.quinella == @rank.gate2
          purchase.get=purchase.price*@dividend.bracket_quinella/100
          purchase.save
        elsif purchase.betting_ticket==5 && purchase.win == @rank.win && purchase.quinella == @rank.second
          purchase.get=purchase.price*@dividend.quinella/100
          purchase.save
        elsif purchase.betting_ticket==6 && purchase.win == @rank.win && purchase.quinella == @rank.second
          purchase.get=purchase.price*@dividend.exacta/100
          purchase.save
        elsif purchase.betting_ticket==4 && purchase.win == @wide1[0] && purchase.quinella == @wide1[1]
          purchase.get=purchase.price*@dividend.quinella_place1/100
          purchase.save
        elsif purchase.betting_ticket==4 && purchase.win == @wide2[0] && purchase.quinella == @wide2[1]
          purchase.get=purchase.price*@dividend.quinella_place2/100
          purchase.save
        elsif purchase.betting_ticket==4 && purchase.win == @wide3[0] && purchase.quinella == @wide3[1]
          purchase.get=purchase.price*@dividend.quinella_place3/100
          purchase.save
        elsif purchase.betting_ticket==7 && purchase.win == @rank.win && purchase.quinella == @rank.second && purchase.trio == @rank.third
          purchase.get=purchase.price*@dividend.trio/100
          purchase.save
        elsif purchase.betting_ticket==8 && purchase.win == @rank.win && purchase.quinella == @rank.second && purchase.trio == @rank.third
          purchase.get=purchase.price*@dividend.trifecta/100
          purchase.save
        else
          purchase.get=0
          purchase.save
        end
      end     
    end
    @users=User.all
    @users.each do |user|
      @sum_price=Purchase.where(list_id: @list.id,user_id: user.id).sum(:price)
      @sum_get=Purchase.where(list_id: @list.id,user_id: user.id).sum(:get)
      if @sum_get==0 
        @hit=0
      else
        @hit=1
      end
      @recovery=Recovery.find_by(list_id: @list.id,user_id: user.id,year: @list.year)
      if  @recovery== nil
        @recovery=Recovery.new(list_id: @list.id,user_id: user.id,sum_price: @sum_price,sum_get:@sum_get,hit:@hit,year:@list.year)
        @recovery.save
      else 
        @recovery.update(list_id: @list.id,user_id: user.id,sum_price: @sum_price,sum_get:@sum_get,hit:@hit,year:@list.year)
      end
    end  
    redirect_to('/admin/calculate')
  end

  def question
    @questions=Question.all
  end

  def document
    @document=Question.find_by(id: params[:id])
  end

  def authenticate_admin
    if @current_user.name != "master_g"
      flash[:notice]="権限がありません"
      redirect_to('main/top')
    end
  end

  
end
