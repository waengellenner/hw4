class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "username" => params["username"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome."
        redirect_to "/"
      else
        flash["notice"] = "Incorrect password."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Username does not exist."
      redirect_to "/login"
    end
  end

  def destroy
    session["username"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end
  