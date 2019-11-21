class DosesController < ApplicationController
  before_action :set_dose, only: [:destroy]

  def new
    @dose = Dose.new
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def create
    @dose = Dose.new(dose_params)
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.cocktail = @cocktail
    @dose.save
    if @cocktail.save
      redirect_to cocktail_path(@dose.cocktail.id)
    else
      puts "Dose didn't save"
    end
  end

  def destroy
    set_dose
    @cocktail = @dose.cocktail_id
    @dose.destroy
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
    # why can we put ingredient and not ingredient id?
  end

  def set_dose
    @dose = Dose.find(params[:id])
  end
end
