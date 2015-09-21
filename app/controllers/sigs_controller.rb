class SigsController < ApplicationController
    def index
        @sigs = Sig.all
    end

    def new
    end
    
    def create
        @sig = Sig.new(sig_params)
    
        if @sig.save
            redirect_to @sig
        else
            render 'new'
        end
    end
    
    def show
        @sig = Sig.find(params[:id])
    end
    
    private 
        def sig_params
            params.require(:sig).permit(:title, :url, :description, :analysis)
        end
end
