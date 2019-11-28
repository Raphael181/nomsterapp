class PlacesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :destroy] #this line is what allows our logged in user to create, delete and update the places the user created

    def index
        @places = Place.all
    end


    def new
        @place = Place.new
    end
    
    def create
        current_user.places.create(place_params)
        redirect_to root_path
    end
    
    def show
        @place = Place.find(params[:id]) #this tells the computer to locate the particular id for the place selected
    end
    
    def edit
        @place = Place.find(params[:id])
        
        if @place.user != current_user
            return render plain: 'You are not authorized to do such', status: :forbidden    #this code tells us that no other user except the user who created it can either edit or delete the entered place
        end
    end
    
    def update
     @place = Place.find(params[:id])
     @place.update_attributes(place_params)
     redirect_to root_path
    end
    
    def destroy
        @place = Place.find(params[:id])
        
        if @place.user != current_user
            return render plain: 'You are not authorized to do such', status: :forbidden    #this code tells us that no other user except the user who created it can either edit or delete the entered place
        end
        
        @place.destroy
        redirect_to root_path
    end
    
    private
    
    def place_params
        params.require(:place).permit(:name, :description, :address)
    end

end
