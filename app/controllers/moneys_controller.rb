class MoneysController < ApplicationController
before_action :check_login_user
    def set
        Money.update_all(unused: 3000,used: 0)
        redirect_to('/races/bet')
    end
end
