require_dependency "local_mail/application_controller"

module LocalMail
  class MailsController < ApplicationController
    layout false

    def index
      @emails = Array.new

      Dir.chdir(Rails.root.join('tmp', 'local_mail')) do
        Dir.glob("*") do |dir|
          time = dir.split('_').first
          subject = dir.split('_').second.gsub!('-',' ').humanize + " (To: <#{dir.split('_').third}>)"
          href = dir.split('_').fourth + ( rich_style?(dir) ? '/rich': '/plain' )
          @emails << { time: time, subject: subject, href: href }
        end
      end

      @emails = @emails.sort_by { |email| email[:time] }.reverse.take(200)
    end

    def show
      email_content = ''

      Dir.chdir(Rails.root.join('tmp', 'local_mail')) do
        Dir.glob("*#{params[:hash]}") do |dir|
          if params[:style] != 'plain' && rich_style?(dir)
            email_content = File.read("#{dir}/rich.html")
          else
            email_content = File.read("#{dir}/plain.html")
          end
        end
      end

      fix_links(email_content)

      render text: email_content
    end

    def attachments
      attachment = ''

      Dir.chdir(Rails.root.join('tmp', 'local_mail')) do
        Dir.glob("*#{params[:hash]}") do |dir|
          attachment = File.read("#{dir}/attachments/#{params[:name]}.#{params[:format]}")
        end
      end

      render text: attachment
    end

    private

    def fix_links(text)
      text.sub!(/(<a\s+(?:[^>]*?\s+)?href=)"([^"]*)"/, '\1' + '\2')
    end

    def rich_style?(dir)
      File.exist?("#{dir}/rich.html")
    end
  end
end
