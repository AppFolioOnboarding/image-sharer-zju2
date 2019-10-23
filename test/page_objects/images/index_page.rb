module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      element :flash_message, locator: '.notice'
      collection :all_images, locator: '#js-all-images', item_locator: '.js-one-image', contains: ImageCard do
        def view!
          node.find('img').click
          window.change_to(ShowPage)
        end
      end

      def add_new_image!
        node.click_on('Upload Image')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        false if url.nil?
        all_images.each do |image|
          if image.url.present?
            matched_image = tags.nil? ? image.url == url : image.url == url && image.tags.present? && image.tags == tags
            return true if matched_image
          end
        end
        false
      end

      def clear_tag_filter!
        PageObjects::Images::IndexPage.visit
      end
    end
  end
end
