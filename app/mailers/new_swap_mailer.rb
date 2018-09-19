class NewSwapMailer < ApplicationMailer
    default from: "noreply@ikalogs.ru"

    def sendmail(collection, cnt)
        @collection = collection
        @cnt = cnt

        mail(to: @collection.user.email, from: ENV['gmail_username'], subject: 'New request to exchange');
    end
end
