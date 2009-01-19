class PrivateMessageMailer < ActionMailer::Base
  def get_admin_email
    User.find(:first, :conditions => {:admin => true}).email
  end

  def notification(sender, recipient, domain, messages_url, sent_at = Time.now)
    @subject    = "[Forexwk.com] Вы получили личное сообщение от {sender}"
    @body       = {:sender => sender, :recipient => recipient, :domain => domain, :messages_url => messages_url}
    @recipients = recipient.email
    @from       = get_admin_email
    @sent_on    = sent_at
    @headers    = {}
    @content_type = 'text/html'
  end
  
end
