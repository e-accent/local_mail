
```ruby
# Gemfile.rb
gem 'local_mail', git: 'https://github.com/weih/local_mail.git', group: :development
    
# routes.rb
Your::Application.routes.draw do
  if Rails.env.development?
    mount LocalMail::Engine, at: "/local_mail"
  end
end

# Email will be saved at tmp/local_mail folder
```
