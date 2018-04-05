class FermentablesController < ApplicationController
  def show
    @fermentable = Fermentable.find(params[:id])
  end

  def edit
    @fermentable = Fermentable.find(params[:id])
  end

  def update
    @fermentable = Fermentable.find(params[:id])
    @fermentable.update(fermentable_params)

    redirect_to fermentable_path(@fermentable)
  end

  private

    def fermentable_params
      params.require(:fermentable).permit(:name, :lovibond)
    end

end
