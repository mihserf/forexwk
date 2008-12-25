class Message < ActionMailer::Base

  def send_message(message, name, email)
    recipients User.find(:first, :conditions => {:admin => true}).email
    subject "Сообщение с сайта"
    from email
    body ({:message => message, :name => name})
    content_type 'text/html'
  end
  

end
