class ItemsController < ApplicationController
  def index
    @exhibit = Exhibit.find(params[:exhibit_id])

    respond_to do |format|
      format.json { render json: remote_json(@exhibit.items_json_url) }
    end
  end

  def show
    @exhibit = Exhibit.find(params[:exhibit_id])

    respond_to do |format|
      format.json { render json: remote_json(@exhibit.item_json_url(params[:id])) }
    end
  end

  private

    def remote_json(url)
      require 'open-uri'
      open(url) {|io| io.read}
    end

end
