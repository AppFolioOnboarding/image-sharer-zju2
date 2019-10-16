require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = Image.create!(link: 'https://i.imgur.com/8GaYYya.jpg')
  end

  def test_new
    get new_image_path

    assert_response :ok
    assert_select 'h1', 'Save new Image Here!'
    assert_select '.simple_form'

    assert_select '#new_image', 1
    assert_select '#new_image' do
      assert_select '.image_link'
      assert_select '.image_tag_list'
    end

    assert_select 'a', 'Go Back to homepage'
  end

  def test_index
    get images_path

    assert_response :ok
    assert_select 'h1', 'All Images'
    assert_select 'ul'

    assert_select 'a', 'Upload Image'
  end

  def test_index_has_tags
    @image = Image.create!(link: 'https://i.imgur.com/8GaYYya.jpg', tag_list: 'fall, kid')
    get images_path

    assert_response :ok
    assert_select 'h1', 'All Images'
    assert_select 'ul'

    assert_select 'li.this_tag:nth-child(1)', 'fall'
    assert_select 'li.this_tag:nth-child(2)', 'kid'

    assert_select 'a', 'Upload Image'
  end

  def test_index_no_tag
    @image = Image.create!(link: 'https://i.imgur.com/8GaYYya.jpg')
    get images_path

    assert_response :ok
    assert_select 'h1', 'All Images'
    assert_select 'ul'

    assert_select '.no_tag_here'
    assert_select 'strong', '(No tags for this image)'

    assert_select 'a', 'Upload Image'
  end

  def test_index_image_order
    url1 = 'https://i.imgur.com/eMroIPL.jpg'
    url2 = 'https://i.imgur.com/yKAX9Fm.jpg'
    url3 = 'https://i.imgur.com/IvVjToQ.jpg'
    Image.create!(link: url1)
    Image.create!(link: url2)
    Image.create!(link: url3)

    get images_path
    assert_response :ok

    assert_select 'ul'
    assert_select 'li'

    assert_select 'li:nth-child(1)' do
      assert_select format('img[src="%<url>s"]', url: url3)
    end

    assert_select 'li:nth-child(2)' do
      assert_select format('img[src="%<url>s"]', url: url2)
    end

    assert_select 'li:nth-child(3)' do
      assert_select format('img[src="%<url>s"]', url: url1)
    end
  end

  def test_show_no_tag
    @image = Image.create!(link: 'https://i.imgur.com/8GaYYya.jpg')
    get image_path(@image.id)

    assert_response :ok
    assert_select '#Header', 'This is the show page'
    assert_select 'img[src=?]', 'https://i.imgur.com/8GaYYya.jpg'
    assert_select '#no_tag_here'

    assert_select 'a', 'Homepage'
  end

  def test_show_has_tags
    @image = Image.create!(link: 'https://i.imgur.com/8GaYYya.jpg', tag_list: 'fall, kid')
    get image_path(@image.id)

    assert_response :ok
    assert_select '#Header', 'This is the show page'
    assert_select 'img[src=?]', 'https://i.imgur.com/8GaYYya.jpg'

    assert_select '#no_tag_here', false
    assert_select 'li', 2
    assert_select 'li.this_tag', 'fall'
    assert_select 'li.this_tag', 'kid'

    assert_select 'a', 'Homepage'
  end

  def test_create__succeed
    assert_difference('Image.count', 1) do
      image_param = { link: 'https://i.imgur.com/8GaYYya.jpg' }
      post images_path, params: { image: image_param }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'Image was successfully created', flash[:notice]
    assert_empty Image.last.tag_list
  end

  def test_create_with_tag__succeed
    assert_difference('Image.count', 1) do
      image_params = { link: 'https://i.imgur.com/8GaYYya.jpg', tag_list: 'fall, kid' }
      post images_path, params: { image: image_params }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'Image was successfully created', flash[:notice]
    assert_equal %w[fall kid], Image.last.tag_list
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
