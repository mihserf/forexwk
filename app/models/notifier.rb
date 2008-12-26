class Notifier < ActionMailer::Base

  default_url_options[:host] = "forexwk.com"

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "ForexWK <noreply@forexwk.com>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def message_rating_changed(user, rating_val, reason)
    subject       "Изменение рейтинга"
    from          "ForexWK <noreply@forexwk.com>"
    recipients    user.email
    sent_on       Time.now
    body({:raing_val => rating_val,:reason => reason})
  end

  def message_addition_added(user, addition)
    subject       "Дополнение к Вашей статье"
    from          "ForexWK <noreply@forexwk.com>"
    recipients    user.email
    sent_on       Time.now
    body({:addition => addition})
  end

  def message_comment_added(user, comment)
    subject       "Комментарий к Вашему дополнению"
    from          "ForexWK <noreply@forexwk.com>"
    recipients    user.email
    sent_on       Time.now
    body({:comment => comment})
  end

  def message_new_contest(user, contest)
    subject       "Изменение рейтинга"
    from          "ForexWK <noreply@forexwk.com>"
    recipients    user.email
    sent_on       Time.now
    body({:contest => contest})
  end

end
