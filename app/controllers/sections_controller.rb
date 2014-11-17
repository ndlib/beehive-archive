class SectionsController < ApplicationController

  def index
    @sections = Section.all
  end


  def show

  end


  def create
    @section = Section.new(section_params)
    puts section_params
    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end


  def update

  end


  def destroy

  end


  protected

    def section_params
      params.require(:section).permit(:title, :image, :item_id, :description)
    end
end
