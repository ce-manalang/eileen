class Comment < ApplicationRecord
  belongs_to :message
  has_rich_text :body
end
