class TimeCardsController < ApplicationController
  before_action only: %i[index edit destroy]

  def index
    @developer = Developer.find(params[:developer_id])
    @time_Cards = @developer.time_Cards
  end

  def show
    @time_card = TimeCard.find(params[:id])
    @developer = current_developer
  end

  def new
    @time_card = TimeCard.new
    @developer = current_developer
  end

  def edit
    @developer = Developer.find(params[:developer_id])
    @time_card = TimeCard.find(params[:id])
  end

  def create
    @developer = Developer.find(params[:developer_id])
    @time_card = @developer.time_Cards.build(time_card_params)
    if @time_card.save
      redirect_to developer_time_card_path(@developer, @time_card)
    else
      render 'new'
    end
  end

  def destroy
    @developer = Developer.find(params[:developer_id])
    @time_card = TimeCard.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to developer_time_Cards_path(@developer) }
    end
  end

  private

  def time_card_params
    params.require(:time_card).permit(:entry, :date_field, :developer_id, :project_id, projects_attributes: %i[name description], developers_attributes: %i[id name email], developers_projects_attributes: %i[developer_id project_id])
  end
end
