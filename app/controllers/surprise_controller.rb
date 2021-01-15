class SurpriseController < ApplicationController
  def index
    if Image.count > 0
      redirect_to image_path(Image.find(Image.open.pluck(:id).sample))
    else
      flash[:notice] = "There are no open images to view!"
      redirect_to images_path
    end
  end
end
