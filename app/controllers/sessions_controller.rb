class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
    end
  
    session[:user_id] = @user.id
  
    render 'welcome/home'
  end
  
  def destroy
    session.delete :user_id
    redirect_to sessions_new_path
  end


private 
    def auth
      request.env['omniauth.auth']
    end
end
