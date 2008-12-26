class Notifier < ActionMailer::Base
  def get_admin_email
    User.find(:first, :conditions => {:admin => true}).email
  end
  
  default_url_options[:host] = "forexwk.com"

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def message_rating_changed(user, rating_val, reason)
    subject       "Изменение рейтинга"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body({:user => user,:rating_val => rating_val,:reason => reason})
    content_type 'text/html'
  end

  def message_addition_added(user, addition)
    subject       "Дополнение к Вашей статье"
    from          @get_admin_email
    recipients    user.email
    sent_on       Time.now
    body({:addition => addition})
    content_type 'text/html'
  end

  def message_comment_added(user, comment)
    subject       "Комментарий к Вашему дополнению"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body({:comment => comment})
    content_type 'text/html'
  end

  def message_new_contest(user, contest)
    subject       "Изменение рейтинга"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body({:contest => contest})
    content_type 'text/html'
  end

end
