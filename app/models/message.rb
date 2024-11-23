class Message < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_rich_text :body
  has_many :comments, -> { order(created_at: :asc) }, dependent: :destroy # Ensures comments are deleted if the message is deleted
end