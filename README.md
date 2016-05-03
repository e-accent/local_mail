
```ruby
# Gemfile.rb
gem 'local_mail', :git =>  'https://github.com/e-accent/local_mail.git', :group => [:development, :staging]
    
# config/routes.rb
Your::Application.routes.draw do
  if Rails.env.development? or Rails.env.staging?
    mount LocalMail::Engine, at: "/local_mail"
  end
end

# config/environments/development.rb or config/environments/staging.rb
config.action_mailer.delivery_method = :local_mail

# Remember to start sidekiq or resque service if you're using async mail sending

# Email will be saved at tmp/local_mail folder
```
