class RacesController < ApplicationController
before_action :check_login_user

  def large_prize1
    @horses=Horse.where(list_id:@list.id,prize_number: 1)
    @rank=Rank.find_by(list_id: @list.id)
    @result_horse1=Horse.find_by(horse_number: @rank.win)
    @result_horse2=Horse.find_by(horse_number: @rank.second)
    @result_horse3=Horse.find_by(horse_number: @rank.third)
  end

  def large_prize2
    @horses=Horse.where(list_id:@list.id,prize_number: 2)
  end

  def bet
    @horses=Horse.where(list_id: @list.id)
  end

  def win
    @horses = Horse.where(list_id: @list.id)
    @betting_ticket=params[:race_id].to_i
    @betting=BettingTicket.find_by(id: @betting_ticket)
  end

  def quinella
    @horses=Horse.where(list_id: @list.id)
    @betting_ticket=params[:race_id].to_i
    @betting=BettingTicket.find_by(id: @betting_ticket)
  end

  def trio
    @horses=Horse.where(list_id: @list.id)
    @betting_ticket=params[:race_id].to_i
    @betting=BettingTicket.find_by(id: @betting_ticket)
  end

  def value1
    @selections=Selection.where(user_id: @current_user.id,list_id: @list.id)
    if @selections!=nil
      @selections.destroy_all
    end
    @betting_ticket=params[:race_id].to_i
    @checkbox=[]
    params[:first_horse].each do |d1,d2|
      if d2.to_i==1
        @checkbox.push(d1.to_i)
      end
    end
      if !@checkbox.empty?
          @checkbox.each do |t1|
          @select=Selection.new(user_id: @current_user.id,win: t1,betting_ticket: @betting_ticket,list_id: @list.id)
          @select.save
        end
      redirect_to('/races/play')  
      else
        flash[:notice]='馬を選択してください'
        redirect_to("/races/win/#{@betting_ticket}")
      end
  end

    def value2
      @selections=Selection.where(user_id: @current_user.id,list_id: @list.id)
    if @selections!=nil
      @selections.destroy_all
    end
      @betting_ticket=params[:race_id].to_i
      @checkbox1=[]
      @checkbox2=[]
      params[:first_horse].each do |d1,d2|
        if d2.to_i==1
          @checkbox1.push(d1.to_i)
        end
      end
      params[:second_horse].each do |d1,d2|
        if d2.to_i==1
          @checkbox2.push(d1.to_i)
        end
      end
      if !@checkbox1.empty? && !@checkbox2.empty? 
        if @betting_ticket == 3
          @change_gate1=[]
          @change_gate2=[]
          @checkbox1.each do |box1|
            @change_gate1.push(Horse.find_by(horse_number: box1).gate_number)
          end
          @checkbox2.each do |box2|
            @change_gate2.push(Horse.find_by(horse_number: box2).gate_number)
          end
          @checkbox1=@change_gate1  
          @checkbox2=@change_gate2  
        end  
        @checkbox1.each do |t1|
          @checkbox2.each do |t2|
            if t1!=t2 
              @select=Selection.new(user_id: @current_user.id,win: t1,quinella: t2,betting_ticket: @betting_ticket,list_id:@list.id)
              if @betting_ticket == 6
                @select.save
              else
                 @reverse_select=Selection.find_by(user_id: @current_user.id,win: t2,quinella: t1,betting_ticket: @betting_ticket,list_id: @list.id)
                 if @reverse_select==nil
                    @sort=[@select.win,@select.quinella]
                    @new_sort=@sort.sort
                    @select.win=@new_sort[0]
                    @select.quinella=@new_sort[1]
                    @select.save
                 else
                    @select=nil
                 end
                 if @betting_ticket==3
                    @double_choice=Selection.where(user_id: @current_user.id,win: t1,quinella: t2,betting_ticket: @betting_ticket,list_id: @list.id)
                    if @double_choice!= nil && @double_choice.count == 2
                      @double_choice[0].destroy
                    elsif @double_choice!= nil && @double_choice.count == 3
                      @double_choice[0].destroy
                      @double_choice[1].destroy
                    end
                 end

              end
            elsif @betting_ticket==3 && t1==t2
              if Horse.where(gate_number: t1).count >= 2
                @select_check=Selection.find_by(user_id: @current_user.id,win: t1,quinella: t2,betting_ticket: @betting_ticket,list_id:@list.id)
                if @select_check==nil
                  @select=Selection.new(user_id: @current_user.id,win: t1,quinella: t2,betting_ticket: @betting_ticket,list_id:@list.id)
                  @select.save
                end
              end
            end
          end
        end
        redirect_to('/races/play')  
      else
        flash[:notice]='選択１、選択２に空欄があります'
        redirect_to("/races/quinella/#{@betting_ticket}")
      end
  end

  def value3
      @selections=Selection.where(user_id: @current_user.id,list_id: @list.id)
    if @selections!=nil
      @selections.destroy_all
    end
      @betting_ticket=params[:race_id]
      @checkbox1=[]
      @checkbox2=[]
      @checkbox3=[]
      params[:first_horse].each do |d1,d2|
        if d2.to_i==1
          @checkbox1.push(d1.to_i)
        end
      end
      params[:second_horse].each do |d1,d2|
        if d2.to_i==1
          @checkbox2.push(d1.to_i)
        end
      end
      params[:third_horse].each do |d1,d2|
        if d2.to_i==1
          @checkbox3.push(d1.to_i)
        end
      end
      if !@checkbox1.empty? && !@checkbox2.empty? && !@checkbox3.empty?
        @checkbox1.each do |t1|
          @checkbox2.each do |t2|
            @checkbox3.each do |t3|
              if t1!=t2 && t1!=t3 && t2!=t3 
                @select=Selection.new(user_id: @current_user.id,win: t1,quinella: t2,trio: t3,betting_ticket: @betting_ticket,list_id: @list.id)
                if @betting_ticket==8
                  @select.save
                else
                  @reverse_select1=Selection.find_by(user_id: @current_user.id,win: t2,quinella: t1,trio: t3,betting_ticket: @betting_ticket)
                  @reverse_select2=Selection.find_by(user_id: @current_user.id,win: t3,quinella: t1,trio: t2,betting_ticket: @betting_ticket)
                  @reverse_select3=Selection.find_by(user_id: @current_user.id,win: t3,quinella: t2,trio: t1,betting_ticket: @betting_ticket)
                  @reverse_select4=Selection.find_by(user_id: @current_user.id,win: t2,quinella: t3,trio: t1,betting_ticket: @betting_ticket)
                  @reverse_select5=Selection.find_by(user_id: @current_user.id,win: t1,quinella: t3,trio: t2,betting_ticket: @betting_ticket)
                  if @reverse_select1!=nil || @reverse_select2!=nil || @reverse_select3!=nil || @reverse_select4!=nil || @reverse_select5!=nil
                    @select=nil
                  else
                    @sort=[@select.win,@select.quinella,@select.trio]
                    @new_sort=@sort.sort
                    @select.win=@new_sort[0]
                    @select.quinella=@new_sort[1]
                    @select.trio=@new_sort[2]
                    @select.save
                  end
                end
              end
            end
          end  
        end
        redirect_to('/races/play')
      else
        flash[:notice]='選択１、選択２、選択３のいずれかが選択されていません'
        redirect_to("/races/trio/#{@betting_ticket}")
      end
  end

  def play
    @selections=Selection.where(user_id: @current_user.id)
    if @selections!=nil
      @betting=BettingTicket.find_by(id: @selections[0].betting_ticket)
    else
      flash[:notice]='購入不可の馬券です'
      redirect_to('/races/bet')
    end
  end
end

