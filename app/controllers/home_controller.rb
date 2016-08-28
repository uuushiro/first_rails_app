class HomeController < ApplicationController
  def top
    if user_signed_in?
      @note = Note.new
      @notes = Note.all.order(created_at: :desc)
    else
      @message = "JUSTONEを始めましょう！"
    end
  end

  def about
  end

end
