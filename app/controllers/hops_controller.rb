class HopsController < ApplicationController
  def index
    @hops = Hop.all

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @hops }
    end
  end

end
