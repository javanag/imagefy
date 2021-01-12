class SurpriseController < ApplicationController
  def index
    redirect_to image_path(Image.find(Image.open.pluck(:id).sample))
  end
end
