class TalksController < ApplicationController

  def create
    @talk = Talk.new(talk_params)
    @talk.from_id = current_user.id
    if @talk.save
      render 'home/about'
    else
      render 'home/top'
    end
  end

  def index
    @talk = Talk.new
    @talks = Talk.all.order(created_at: :desc)
    @user = User.find(params[:id])
  end


private

  def talk_params
    params.require(:talk).permit(:content, :to_id)
  end

end
