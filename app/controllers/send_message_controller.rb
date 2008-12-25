class SendMessageController < ApplicationController
  def create
    email = params[:email]
    name = params[:name]
    message = params[:message]

    unless email=="" || name==""  || message==""
      Message.deliver_send_message(message, name, email)
      flash[:notice] = 'Сообщение отправлено. Вам ответят вближайшее время на Ваш email'
      redirect_to :back
    else
      flash[:error] = 'Сообщение не отправлено. Заполните все поля.'
      redirect_to :back
    end

  end
end
