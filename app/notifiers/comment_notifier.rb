# To deliver this notification:
#
# CommentNotifier.with(record: @post, message: "New post").deliver(User.all)

class CommentNotifier < ApplicationNotifier
  # Add your delivery methods
  #
  deliver_by :email do |config|
    config.mailer = "UserMailer"
    config.method = :new_comment
    config.params = -> { {user: recipient} }
  end

  def message
    "This is my foo: #{params[:foo]}"
  end

  notification_methods do
    def message
      "This is #{recipient.email}'s foo: #{params[:foo]}"
    end
  end
  
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message
end
