class NotisController < ApplicationController
  def show
  	@new_notis = current_user.notis.where(status: true)
  	@notis = current_user.notis.where(status: false)
  	unless @new_notis.nil?
  		current_user.notis.where(status: true).update_all status: false
  	end
  end

  def destroy
  end
end
