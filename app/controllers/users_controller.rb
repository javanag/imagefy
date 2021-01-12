class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])

    if @user.nil?
      raise ActionController::RoutingError.new('Not Found')
    end

    if @user != current_user
      @images = Image.open
    else
      @images = Image.all
    end

    @images = @images.where(user: @user).order(created_at: :desc)
    @images.each do |image|
      Image.increment_counter(:views, image.id)
    end
  end
end
