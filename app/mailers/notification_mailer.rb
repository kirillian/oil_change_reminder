class NotificationMailer < ApplicationMailer
    def first_notification
        @image = params[:image]

        mail(to: "luke.rogers1843@gmail.com", subject: "How's your oil??")
      end
end
