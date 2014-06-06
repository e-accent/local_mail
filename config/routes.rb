LocalMail::Engine.routes.draw do
  root to: 'mails#index'
  # get '/:hash', to: 'mails#show'
  get '/:hash/:style', to: 'mails#show'
  get '/:hash/attachments/:name', to: 'mails#attachments'
end
