# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
    def first_notification
        # Set up a temporary order for the preview
        image = Image.last
    
        NotificationMailer.with(image: image).first_notification
      end

end
