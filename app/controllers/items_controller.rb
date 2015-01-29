class ItemsController < ApplicationController
  helper_method :exhibit

  def index

    respond_to do |format|
      format.json { render json: ExhibitItemsJsonFormatter.new(exhibit) }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: ExhibitItemJsonFormatter.new(exhibit, params[:id]) }
    end
  end

  private
    def exhibit
      @exhibit ||= Exhibit.find(params[:exhibit_id])
    end

end
