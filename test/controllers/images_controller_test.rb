require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = Image.create!(link: 'https://i.imgur.com/8GaYYya.jpg')
  end

  def test_new
    get new_image_path

    assert_response :ok
  end

  def test_show
    get image_path(@image.id)

    assert_response :ok
    assert_select '#Header', 'This is the show page'
    assert_select 'img[src=?]', 'https://i.imgur.com/8GaYYya.jpg'
  end

  def test_create__succeed
    assert_difference('Image.count', 1) do
      image_param = { link: 'https://i.imgur.com/8GaYYya.jpg' }
      post images_path, params: { image: image_param }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'Image was successfully created', flash[:notice]
  end

  def test_create__fail
    assert_no_difference('Image.count') do
      image_param = { link: 'jpg' }
      post images_path, params: { image: image_param }
    end

    assert_response :unprocessable_entity
    assert_select '.error', 'is an invalid URL'
  end
end
