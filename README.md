= LocalMail

This project rocks and uses MIT-LICENSE.## Installation

First add the gem to your development environment and run the `bundle` command to install it.

    gem 'local_mail', git: 'https://github.com/weih/local_mail.git', group: :development

## Usage

Add to your routes.rb:

```ruby
Your::Application.routes.draw do
  if Rails.env.development?
    mount LocalMail::Engine, at: "/local_mail"
  end
end
```
