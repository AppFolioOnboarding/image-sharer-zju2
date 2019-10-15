require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def test_image_url__valid
    image = Image.new(link: 'https://imgur.com/t/fall/dwxn8tL')

    assert_predicate image, :valid?
  end

  def test_image_url__invalid_if_it_is_not_valid
    image = Image.new(link: 'not valid url')

    refute_predicate image, :valid?
    puts image.errors.messages[:link]
    assert_equal 'is an invalid URL', image.errors.messages[:link].first
  end
end
