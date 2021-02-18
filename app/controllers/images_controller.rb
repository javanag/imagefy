class ImagesController < ApplicationController
  def index
    @images = Image.open.order(created_at: :desc).page(params[:page])
    @images.each do |image|
      Image.increment_counter(:views, image.id)
    end
  end

  def create
    permitted_params = image_params

    new_image = Image.create!(
      user: current_user,
      title: permitted_params[:title],
      description: permitted_params[:description],
      access_level: permitted_params[:access_level],
      tags: permitted_params[:tags],
      image_file: permitted_params[:image_file]
    )

    redirect_to image_path(new_image)
  end

  def show
    @image = Image.find(params[:id])
    
    if @image.secret? && current_user != @image.user
      raise ActionController::RoutingError.new('Not Found')
    end

    Image.increment_counter(:views, @image.id)
  end

  def edit
  end

  def update
  end

  def destroy
    image = Image.find(params[:id])

    if current_user != image.user
      flash[:alert] = "Can't delete image, unauthorized user"
    else
      image.destroy
      flash[:notice] = "Image deleted successfully"
    end

    if URI(request.referer).path == image_path(image)
      redirect_to root_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def image_params
    params
      .require(:image)
      .permit(:description, :tags, :title, :image_file, :access_level)
  end
end
