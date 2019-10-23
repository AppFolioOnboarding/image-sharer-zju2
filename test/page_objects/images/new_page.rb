module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_image
      path :image

      element :flash_message, locator: '.notice'
      element :new_page_locator, locator: '.js-new-page'

      form_for :image do
        element :link, locator: '#image_link'
        element :tag_list, locator: '#image_tag_list'
      end

      def create_image!(link: nil, tag_list: nil)
        self.link.set(link) if link.present?
        self.tag_list.set(tag_list) if tag_list.present?

        node.click_on('save')
        window.change_to(ShowPage, NewPage)
      end
    end
  end
end
