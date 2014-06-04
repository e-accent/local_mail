require_dependency "local_mail/application_controller"

module LocalMail
  class MailsController < ApplicationController
    def index
      render text: controller_name.upcase
    end
  end
end
