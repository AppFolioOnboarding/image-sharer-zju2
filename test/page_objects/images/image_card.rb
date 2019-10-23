module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      def url
        node.find('img')[:src]
      rescue Capybara::ElementNotFound
        ''
      end

      def tags
        node.find_all('.js-index-tag').map(&:text)
      rescue Capybara::ElementNotFound
        ''
      end

      def click_tag!(tag_name)
        tags_to_click = node.find_all('.js-index-tag') do |i|
          i.text == tag_name
        end
        tags_to_click.first.click
        window.change_to(IndexPage)
      end
    end
  end
end
