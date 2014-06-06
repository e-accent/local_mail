require 'letter_opener'

module LocalMail
  class DeliveryMethod < LetterOpener::DeliveryMethod
    def deliver!(mail)
      location = File.join(settings[:location], "#{Time.now.strftime("%Y-%m-%d-%H:%M:%S")}_#{mail.subject.downcase.gsub!(' ','-')}_#{mail.to.join(', ')}_#{Digest::SHA1.hexdigest(mail.encoded)[0..6]}")
      messages = LetterOpener::Message.rendered_messages(location, mail)
    end
  end
end
