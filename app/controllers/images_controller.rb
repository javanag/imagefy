class ImagesController < ApplicationController
  def index
  end

  def create
    permitted_params = image_params
    tags = parse_tags(permitted_params[:tags])

    new_image = Image.create!(
      user: current_user,
      title: permitted_params[:title],
      description: permitted_params[:description],
      access_level: permitted_params[:access_level],
      tags: tags
    )

    new_image.image_file.attach(permitted_params[:image_file])
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
  end

  private

  def image_params
    params
      .require(:image)
      .permit(:description, :tags, :title, :image_file, :access_level)
  end

  def parse_tags(tags)
    tags_list = []

    unless tags.blank?
        tags.split(',').each do |tag|
          tags_list.push(tag.strip)
        end

        tags_list.uniq.sort.join(',')
    end
  end
end
