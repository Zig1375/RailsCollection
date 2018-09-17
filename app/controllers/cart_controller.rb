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
        if ((!session[:swap]) || (!session[:swap][params[:collection_id]]) || (session[:swap][params[:collection_id]].count == 0))
            redirect_to @collection
            return
        end

        @collection = Collection.find(params[:collection_id])
        if @collection.nil?
            render 'show'
            return
        end

        @swap = Swap.new(swap_params.merge(collection_id: @collection.id))

        if @swap.save
            session[:swap][params[:collection_id]].each do |id|

            end

            redirect_to @collection
        else
            render 'show'
        end
    end

private
    def swap_params
        params.require(:swap).permit(:name, :email, :message)
    end
end
