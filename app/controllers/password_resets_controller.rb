class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  before_filter :require_no_user

  def new
    render
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "Инструкции по смене пароля были высланы на Ваш email. " +
        "Пожалуйста, проверьте email."
      redirect_to root_url
    else
      flash[:notice] = "Пользователь с таким email не был найден"
      render :action => :new
    end
  end

  def edit
    render
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "Пароль успешно обновлён"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  private
    def load_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:id])
      unless @user
        flash[:notice] = "Извините, но мы не можем найти ваш аккаунт. " +
          "Попробуйте скопировать и вставить URL " +
          "из вашенр письма в строку броузера, либо начните заново процесс " +
          "восстановления пароля."
        redirect_to root_url
      end
    end


end
