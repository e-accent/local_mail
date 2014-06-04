Rails.application.routes.draw do

  mount LocalMail::Engine => "/local_mail"
end
