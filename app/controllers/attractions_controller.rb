class AttractionsController < ApplicationController
    def new
        @attraction = Attraction.new
    end

    def create
        attraction = Attraction.new(attraction_params)
        if attraction.save
            redirect_to attraction_path(attraction)
        else
            redirect_to new_attraction_path
        end
    end

    def index
        @attractions = Attraction.all
        current_user.admin ? @detail_text_start = "Show" : @detail_text_start = "Go on"
    end

    def show
        @attraction = Attraction.find(params[:id])
        @ride = @attraction.rides.build(user_id: current_user.id)
    end

    def edit
        @attraction = Attraction.find(params[:id])
    end

    def update
        attraction = Attraction.find(params[:id])
        attraction.update(attraction_params)
        redirect_to attraction_path(attraction)
    end

    private

    def attraction_params
        params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)    
    end
end