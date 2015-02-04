class ExhibitsController < ApplicationController
  skip_before_filter :redirect_to_sign_in, only: [:show]

  def index
    @exhibits = ExhibitQuery.new.all_for_user(current_user)
  end

  def show
    @exhibit = Exhibit.find(params[:id])
  end

  def new
    @exhibit = Exhibit.new(collection_id: 1)
  end

  def create
    @exhibit = Exhibit.new(save_params)

    if @exhibit.save
      redirect_to exhibits_path
    else
      render :new
    end
  end

  def edit
    @exhibit = Exhibit.find(params[:id])
  end

  def update
    @exhibit = Exhibit.find(params[:id])

    if @exhibit.update_attributes(save_params)
      redirect_to exhibits_path
    else
      render :edit
    end
  end

  def destroy
    @exhibit = Exhibit.find(params[:id])

    if @exhibit.destroy()
      redirect_to exhibits_path
    end
  end

  protected

    def save_params
      params.require(:exhibit).permit([:title, :collection_id])
    end
end
