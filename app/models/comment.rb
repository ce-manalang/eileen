class Comment < ApplicationRecord
  belongs_to :message
  has_rich_text :body
  belongs_to :author, class_name: 'User'
end
