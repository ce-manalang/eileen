class Message < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_rich_text :body
  has_many :comments, dependent: :destroy # Ensures comments are deleted if the message is deleted
end