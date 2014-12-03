class ExhibitsController < ApplicationController

  def index
    @exhibits = ExhibitQuery.new.all_for_user(current_user)
  end

  def show
    @exhibit = Exhibit.find(params[:id])
  end

  def items
    @exhibit = Exhibit.find(params[:id])

    respond_to do |format|
      format.json do
        require 'open-uri'
        json_contents = open(@exhibit.items_json_url) {|io| io.read}
        render json: json_contents
      end
    end
  end
end
