class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params.require(:image).permit(:link, :tag_list))

    if @image.save
      redirect_to @image, notice: 'Image was successfully created'
    else
      redirect_to new_image_path, notice: @image.errors.full_messages.join(',').to_s
    end
  end

  def show
    @image = Image.find_by(id: image_param)

    redirect_to images_path unless @image.present?
  end

  def index
    @tag = params[:tag]
    @images = if @tag.present?
                Image.tagged_with(@tag).order(created_at: :desc)
              else
                Image.all.order(created_at: :desc)
              end
  end

  def destroy
    @image = Image.find_by(id: image_param)
    @image.destroy

    redirect_to images_path, notice: 'Image was successfully deleted'
  end

  private

  def image_param
    params.require(:id)
  end
end
