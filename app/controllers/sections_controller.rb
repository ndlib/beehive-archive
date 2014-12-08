class SectionsController < ApplicationController

  def index
    @sections = ShowcaseList.new(SectionQuery.new.all_in_showcase(showcase), showcase)
  end

  def show
    @section = showcase.sections.find(params[:id])
  end

  def new
    @section = showcase.sections.build
  end

  def create
    @section = showcase.sections.build

    puts @section.errors.inspect
    respond_to do |format|
      if SaveSection.call(@section, section_params)
        format.html { redirect_to exhibit_showcase_sections_path(exhibit, showcase), notice: 'Section Created' }
        format.json { render :show, status: :created, location: exhibit_showcase_section_path(exhibit, showcase, @section) }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @section = showcase.sections.find(params[:id])
  end

  def update
    @section = showcase.sections.find(params[:id])

    respond_to do |format|
      if SaveSection.call(@section, section_params)
        format.html { redirect_to exhibit_showcase_sections_path(exhibit, showcase), notice: 'Section updated.' }
        format.json { render :show, status: :updated, location: @section }
      else
        format.html { render :edit }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @section = showcase.sections.find(params[:id])

    respond_to do |format|

      if @section.destroy
        format.json { render json: 'Section deleted successfully', status: 202 }
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
