LocalMail::Engine.routes.draw do
  root to: 'mails#index'
  get '/:hash/:style', to: 'mails#show'
  get '/:hash/attachments/:name', to: 'mails#attachments'
end
