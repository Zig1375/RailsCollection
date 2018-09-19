class CartController < ApplicationController

    def show
        @request = Request.new
        @collection = Collection.find(params[:collection_id])

        if ((!session[:request]) || (!session[:request][params[:collection_id]]) || (session[:request][params[:collection_id]].count == 0))
            redirect_to @collection
            return
        end

        @items = @collection.items.where(id: session[:request][params[:collection_id]])
    end

    def create
        if ((!session[:request]) || (!session[:request][params[:collection_id]]) || (session[:request][params[:collection_id]].count == 0))
            redirect_to @collection
            return
        end

        @collection = Collection.find(params[:collection_id])
        if @collection.nil?
            render 'show'
            return
        end

        @request = Request.new(swap_params.merge(collection_id: @collection.id))

        if @request.save
            session[:request][params[:collection_id]].each do |id|
                item = @collection.items.find(id)
                ItemsRequest.create :item => item, :request => @request
            end

            NewSwapMailer.sendmail(@collection, session[:request][params[:collection_id]].count).deliver
            session[:request][params[:collection_id]] = []

            redirect_to @collection
        else
            render 'show'
        end
    end

private
    def swap_params
        params.require(:request).permit(:name, :email, :message)
    end
end
