module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      element :show_page_locator, locator: '.js-show-page'
      element :image, locator: 'img'

      def image_url
        image.node[:src]
      end

      def tag_list
        node.find_all('#js-image-tag').map(&:text)
      end

      def delete
        node.click_on('Delete')
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        node.click_on('Delete')
        node.driver.browser.switch_to.alert.accept
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        node.click_on('Homepage')
        window.change_to(IndexPage)
      end
    end
  end
end
