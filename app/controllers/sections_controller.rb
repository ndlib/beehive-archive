class SectionsController < ApplicationController

  def index
    @sections = SectionQuery.new.all_in_showcase(showcase)
  end

  def show
    @section = Section.find(params[:id])
  end

  def create
    @section = Section.new

    respond_to do |format|
      if SaveSection.call(@section, section_params)
        format.html { redirect_to @section, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if SaveSection.call(@section, section_params)
        format.html { redirect_to sections_path, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :updated, location: @section }
      else
        format.html { render :edit }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @section = Section.find(params[:id])

    respond_to do |format|

      if @section.destroy
        format.json { render json: 'Item Deleted successfully', status: 202 }
        format.any { redirect_to :index }
      end

    end
  end

  protected

    def section_params
      params.require(:section).permit(:title, :image, :item_id, :description, :order, :caption)
    end

    def exhibit
      @exhibit ||= Exhibit.find(params[:exhibit_id])
    end

    def showcase
      @showcase ||= exhibit.showcases.find(params[:showcase_id])
    end
end
