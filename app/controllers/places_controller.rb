class PlacesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
        @places = Place.all
    end


    def new
        @place = Place.new
    end
    
    def create
        current_user.plaaces.create(place_params)
        redirect_to root_path
    end
    
    def show
        @place = Place.find(params[:id]) #this tells the computer to locate the particular id for the place selected
    end
    
    def edit
    end
    
    private
    
    def place_params
        params.require(:place).permit(:name, :description, :address)
    end

end
