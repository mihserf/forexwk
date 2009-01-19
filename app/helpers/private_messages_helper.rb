module PrivateMessagesHelper

  def private_message_link(user, msg=default_private_message_link_text)
    if logged_in? and current_user.id != user.id
      link_to_function(msg, "show_private_message_form(#{user.id})")
    else
      ''
    end
  end
  
  def private_message_form
    render(:partial => 'private_messages/new_form') if logged_in?
  end
  
  # renders a link to send a private message to a user
  def private_message_for(user)
    return unless logged_in?
    private_message_link(user) + private_message_form
  end
  
  # renders a list of private messages
  def private_messages(context_user = nil, opts={})
    return unless logged_in?
    
    count = if current_user.id == context_user.id
      current_user.private_messages_count
    else
      current_user.private_messages_with_user_count(context_user)
    end
    
    if count.zero?
      content_tag('p', (opts[:no_messages_message]||'Личные сообщения отсутствуют.'))

    else
      private_messages = paginate(params[:page] || 1, PrivateMessage.per_page, count) do |offset, limit|
        find_options = {:include => :sender, :offset => offset, :limit => limit}
        if current_user.id == context_user.id
          current_user.private_messages(find_options)
        else
          current_user.private_messages_with_user(context_user, find_options)
        end
      end
      
      title = if opts[:title]
      elsif current_user.id != context_user.id
        "Ваши личные сообщения с #{context_user.display_name}"
      else
        'Личные сообщения'
      end
      render :partial => 'private_messages/list', :locals => {:private_messages => private_messages,
          :title => title, :target_user => context_user}
    end
  end
  
  protected
    def default_private_message_link_text
      'Отправить личное сообщение'
    end
    
    def paginate(page, per_page, total, &block)
      returning WillPaginate::Collection.new(page, per_page, total) do |pager|
        pager.replace block.call(pager.offset, pager.per_page)
      end  
    end

end
