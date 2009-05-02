class Notifier < ActionMailer::Base
  def get_admin_email
    #User.find(:first, :conditions => {:admin => true}).email
    "Forexwk.com <admin@forexwk.com>"
  end
  def get_moderator_emails
    User.find(:all, :conditions => {:moderator => true}).map{|i| i.email}
  end
  
  default_url_options[:host] = "forexwk.com"

  def password_reset_instructions(user)
    subject       "[Forexwk.com] Инструкции по смене пароля"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def activation_instructions(user)
    subject       "[Forexwk.com] Инструкции по активации аккаунта"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end

  def activation_confirmation(user)
    subject       "[Forexwk.com] Аккаунт активирован"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end

  def message_rating_changed(user, rating_val, reason)
    subject       "[Forexwk.com] Изменение рейтинга"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body({:user => user,:rating_val => rating_val,:reason => reason})
    content_type 'text/html'
  end

  def message_rating_changed_for_article(user, rating_val, reason, obj_id)
    subject       "[Forexwk.com] Изменение рейтинга за статью"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body({:user => user,:rating_val => rating_val,:reason => reason, :obj_id => obj_id})
    content_type 'text/html'
  end

  def message_rating_changed_for_addition(user, rating_val, reason, obj_id)
    subject       "[Forexwk.com] Изменение рейтинга за дополнение"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body({:user => user,:rating_val => rating_val,:reason => reason, :obj_id => obj_id })
    content_type 'text/html'
  end

  def message_addition_added(user, addition)
    subject       "[Forexwk.com] Дополнение к Вашей статье"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body({:addition => addition})
    content_type 'text/html'
  end

  def message_comment_added(user, comment)
    subject       "[Forexwk.com] Комментарий к Вашему дополнению"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body({:comment => comment})
    content_type 'text/html'
  end

  def message_new_contest(user, contest)
    subject       "[Forexwk.com] Новая акция!"
    from          get_admin_email
    recipients    user.email
    sent_on       Time.now
    body({:contest => contest})
    content_type 'text/html'
  end





  def message_to_moderator_new_article(article)
    subject       "Новая статья"
    from          get_admin_email
    recipients    get_moderator_emails
    sent_on       Time.now
    body({:article => article})
    content_type 'text/html'
  end

  def message_to_moderator_new_addition(addition)
    subject       "Новое дополнение"
    from          get_admin_email
    recipients    get_moderator_emails
    sent_on       Time.now
    body({:addition => addition })
    content_type 'text/html'
  end

  def message_to_moderator_new_comment(comment)
    subject       "Новый комментарий"
    from          get_admin_email
    recipients    get_moderator_emails
    sent_on       Time.now
    body({:comment => comment })
    content_type 'text/html'
  end

end
