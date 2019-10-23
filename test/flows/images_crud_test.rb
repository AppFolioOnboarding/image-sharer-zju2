require 'flow_test_helper'

class ImagesCrudTest < FlowTestCase
  test 'add an image' do
    images_index_page = PageObjects::Images::IndexPage.visit

    new_image_page = images_index_page.add_new_image!

    tags = %w[foo bar]
    new_image_page = new_image_page.create_image!(
      link: 'invalid',
      tag_list: tags.join(', ')
    ).as_a(PageObjects::Images::NewPage)
    assert new_image_page.is_a?(PageObjects::Images::NewPage)
    assert_equal 'Link is an invalid URL', new_image_page.flash_message.text

    image_url = 'https://media3.giphy.com/media/EldfH1VJdbrwY/200.gif'
    new_image_page.link.set(image_url)
    new_image_page.tag_list.set(tags.join(', '))

    image_show_page = new_image_page.create_image!
    assert new_image_page.is_a?(PageObjects::Images::NewPage)
    image_show_page = image_show_page.as_a(PageObjects::Images::ShowPage)

    assert_equal image_url, image_show_page.image_url
    assert_equal tags, image_show_page.tag_list

    images_index_page = image_show_page.go_back_to_index!
    assert images_index_page.showing_image?(url: image_url, tags: tags)
  end

  test 'delete an image' do
    cute_puppy_url = 'http://ghk.h-cdn.co/assets/16/09/980x490/landscape-1457107485-gettyimages-512366437.jpg'
    ugly_cat_url = 'http://www.ugly-cat.com/ugly-cats/uglycat041.jpg'
    Image.create!([
      { link: cute_puppy_url, tag_list: 'puppy, cute' },
      { link: ugly_cat_url, tag_list: 'cat, ugly' }
    ])

    images_index_page = PageObjects::Images::IndexPage.visit
    assert_equal 4, images_index_page.all_images.count
    assert images_index_page.showing_image?(url: ugly_cat_url)
    assert images_index_page.showing_image?(url: cute_puppy_url)

    image_to_delete = images_index_page.all_images.find do |image|
      image.url == ugly_cat_url
    end
    image_show_page = image_to_delete.view!

    image_show_page.delete do |confirm_dialog|
      assert_equal 'Confirm to delete this image?', confirm_dialog.text
      confirm_dialog.dismiss
    end

    images_index_page = image_show_page.delete_and_confirm!
    assert_equal 'Image was successfully deleted', images_index_page.flash_message.text

    assert_equal 3, images_index_page.all_images.count
    assert_not images_index_page.showing_image?(url: ugly_cat_url)
    assert images_index_page.showing_image?(url: cute_puppy_url)
  end

  test 'view images associated with a tag' do
    puppy_url1 = 'http://www.pawderosa.com/images/puppies.jpg'
    puppy_url2 = 'http://ghk.h-cdn.co/assets/16/09/980x490/landscape-1457107485-gettyimages-512366437.jpg'
    cat_url = 'http://www.ugly-cat.com/ugly-cats/uglycat041.jpg'
    Image.create!([
      { link: puppy_url1, tag_list: 'superman, cute' },
      { link: puppy_url2, tag_list: 'cute, puppy' },
      { link: cat_url, tag_list: 'cat, ugly' }
    ])

    images_index_page = PageObjects::Images::IndexPage.visit
    [puppy_url1, puppy_url2, cat_url].each do |url|
      assert images_index_page.showing_image?(url: url)
    end

    images_index_page = images_index_page.all_images[1].click_tag!('cute')

    assert_equal 2, images_index_page.all_images.count
    assert_not images_index_page.showing_image?(url: cat_url)

    images_index_page = images_index_page.clear_tag_filter!
    assert_equal 5, images_index_page.all_images.count
  end
end
