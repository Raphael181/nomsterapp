class PhotosController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @place= Place.find(params[:place_id])
        @place.photo.create(upload_params.merge(user: current_user))
        redirect_to place_path(@place)
    end
    
    private
    
    def upload_params
        params.require(:photos).permit(:caption)
    end
end
