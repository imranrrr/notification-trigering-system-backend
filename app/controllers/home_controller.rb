class HomeController < ApplicationController
    
    def index
        render json: {
            message: "sub domain not exist!"
        }
    end

end