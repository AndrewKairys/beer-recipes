class FermentablesController < ApplicationController
  def index
    @fermentable = Fermentable.all

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @fermentable }
    end
  end

end
