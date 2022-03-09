# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :require_no_authentication
  before_action :set_user, only: %i[edit update]

  def create
    @user = User.find_by email: params[:email]

    if @user.present?
      @user.set_password_reset_token

      PasswordResetMailer.with(user: @user).reset_email.deliver_later
    end

    flash[:success] = 'Password reset instructions were sent to your email address'
    redirect_to new_session_path
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = 'Your password was successfully reset'
      redirect_to new_session_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation).merge(admin_edit: true)
  end

  def set_user
    @user = User.find_by email: params[:user][:email],
                         password_reset_token: params[:user][:password_reset_token]

    redirect_to(new_session_path, flash: { warning: 'Could not reset your password' }) unless @user&.password_reset_period_valid?
  end
end
