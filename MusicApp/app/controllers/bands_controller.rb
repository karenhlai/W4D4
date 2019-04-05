class BandsController < ApplicationController
    def index
        @bands = Band.all
        render :index
    end

    def create #register a new band
        @band = Band.new(band_params)

        # debugger
        if @band.save!
            # @band.save! #band is not saving into DB
            redirect_to band_url(@band)
        else 
            flash[:errors] = ["Band's already taken!"]
            redirect_to new_band_url
        end
    end

    def new
        @band = Band.new #where does Band params come from 
        render :new
    end

    def show
        @band = Band.find_by(id: params[:id]) #pass in all params
        if @band
            render :show
        end
    end

    def destroy
        
    end
    
    def update
        
    end

    private
    def band_params
        params.require(:band).permit(:name)
    end
end

