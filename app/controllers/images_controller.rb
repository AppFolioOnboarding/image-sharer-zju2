class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params.require(:image).permit(:link, :tag_list))

    if @image.save
      redirect_to @image, notice: 'Image was successfully created'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  def index
    @images = Image.all
  end
end
