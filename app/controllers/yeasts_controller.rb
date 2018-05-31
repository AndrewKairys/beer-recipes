class YeastsController < ApplicationController
  def index
    @yeasts = Yeast.all

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @yeasts }
    end
  end

end
