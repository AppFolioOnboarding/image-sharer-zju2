class Image < ApplicationRecord
  acts_as_taggable_on :tags
  validates :link, url: true
end
