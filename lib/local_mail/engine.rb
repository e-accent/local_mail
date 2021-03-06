require 'local_mail/delivery_method'

module LocalMail
  class Engine < ::Rails::Engine
    isolate_namespace LocalMail

    initializer "local_mail.add_delivery_method" do
      ActionMailer::Base.add_delivery_method :local_mail, LocalMail::DeliveryMethod, location: Rails.root.join("tmp", "local_mail")
    end

    initializer "local_mail.mkdir" do
      Dir.mkdir('tmp/local_mail') if !Dir.exist?('tmp/local_mail')
    end
  end
end
