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
    @tag = params[:tag]
    @images = if @tag.present?
                Image.tagged_with(@tag).order(created_at: :desc)
              else
                Image.all.order(created_at: :desc)
              end
  end
end
