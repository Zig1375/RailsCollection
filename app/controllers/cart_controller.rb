class CartController < ApplicationController

    def show
        @collection = Collection.find(params[:collection_id])

        if ((!session[:swap]) || (!session[:swap][params[:collection_id]]) || (session[:swap][params[:collection_id]].count == 0))
            redirect_to @collection
            return
        end

        @items = @collection.items.where(id: session[:swap][params[:collection_id]])
    end

    def create
r
    end

end
