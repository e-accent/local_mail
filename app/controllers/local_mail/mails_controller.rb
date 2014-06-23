class LocalMail::MailsController < ApplicationController
  layout false

  before_filter :check_permission

  def index
    @emails = Array.new

    in_mail_directory do |dir|
      time = dir.split('_').first
      subject = dir.split('_').second.gsub('-',' ').humanize + " (To: <#{dir.split('_').third}>)"
      href = dir.split('_').fourth + ( rich_style?(dir) ? '/rich': '/plain' )
      @emails << { time: time, subject: subject, href: href }
    end

    @emails = @emails.sort_by { |email| email[:time] }.reverse.take(200)
  end

  def show
    email_content = ''

    in_mail_directory("*#{params[:hash]}") do |dir|
      email_content = if params[:style] != 'plain' && rich_style?(dir)
                        File.read("#{dir}/rich.html")
                      else
                        File.read("#{dir}/plain.html")
                      end
    end

    fix_links(email_content)

    render text: email_content
  end

  def attachments
    attachment = ''

    in_mail_directory("*#{params[:hash]}") do |dir|
      attachment = File.read("#{dir}/attachments/#{params[:name]}.#{params[:format]}")
    end

    render text: attachment
  end

  protected
  def check_permission
    redirect_to '/' unless current_user.role == 'manager'
  end

  private
  def fix_links(text)
    text.sub!(/(<a\s+(?:[^>]*?\s+)?href=)"([^"]*)"/, '\1' + '\2')
  end

  def rich_style?(dir)
    File.exist?("#{dir}/rich.html")
  end

  def in_mail_directory(pattern = '*')
    Dir.chdir(Rails.root.join('tmp', 'local_mail')) do
      Dir.glob(pattern) do |dir|
        yield dir
      end
    end
  end
end
