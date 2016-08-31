class TalksController < ApplicationController

  def create
    @talk = Talk.new(talk_params)
    @talk.from_id = current_user.id
    if @talk.save
      redirect_to(:back)
    else
      render 'home/top'
    end
  end

  def index
    @talk = Talk.new
    @user = User.find(params[:id])
    # @talks = Talk.all.order(created_at: :desc)
    # @talks = Talk.where(from_id: current_user.id , to_id: @user.id)
    @talks = Talk.where(from_id:[current_user.id,@user.id], to_id:[current_user.id,@user.id]).order(created_at: :desc)
  end



private

  def talk_params
    params.require(:talk).permit(:content, :to_id)
  end

end

    # @talks = Talk.where{(Talk.arel_table[:to_id].eq(current_user.id)).and(Talk.arel_table[:from_id].eq(@user.id))}.or{(Talk.arel_table[:to_id].eq(@user.id)).and(Talk.arel_table[:from_id].eq(current_user.id))}.order(created_at: :desc)
    #
    # @talks = Talk.where{(Talk.arel_table[:to_id].eq(current_user.id))&&(Talk.arel_table[:from_id].eq(@user.id))}||{(Talk.arel_table[:to_id].eq(@user.id))&&(Talk.arel_table[:from_id].eq(current_user.id))}.order(created_at: :desc)
