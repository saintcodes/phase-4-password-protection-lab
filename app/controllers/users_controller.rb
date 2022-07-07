class UsersController < ApplicationController

  def create
    user = User.create(user_params)
    if user.valid?
      render json: user, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      render json: user, status: :ok
    else
      nil
    end

  end

  private 

  def user_params
    params.permit(:username, :password_digest)
  end

end
