class ItemsController < ApplicationController
    def new
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @item = Item.new
    end

    def edit
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @item = @collection.items.find(params[:id])
    end

    def create
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @item = Item.new(item_params.merge(collection_id: @collection.id))

        if @item.save
            params[:categories][:category].each do |category|
                if category != ""
                    puts category

                    cat = @collection.categories.find(category)
                    if cat
                        CategoriesItems.create :category => cat, :item => @item
                    end
                end
            end

            redirect_to collection_path(@collection)
        else
            render 'new'
        end
    end

    def update
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @item = @collection.items.find(params[:id])

        if @item.update(item_params)
            redirect_to collection_path(@collection)
        else
            render 'edit'
        end
    end

    def swap
        @collection = Collection.find(params[:collection_id])
        @item = @collection.items.find(params[:item_id])

        if @item.swappable
            if !session[:request]
                session[:request] = {}
            end

            if !session[:request][params[:collection_id]]
                session[:request][params[:collection_id]] = []
            end

            if session[:request][params[:collection_id]].include? params[:item_id]
                session[:request][params[:collection_id]].delete(params[:item_id])
            else
                session[:request][params[:collection_id]].push(params[:item_id])
            end
        end

        result = {status: "ok", request: session[:request][params[:collection_id]]}
        render json: result
    end

    def destroy
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @item = @collection.items.find(params[:id])
        @item.destroy
        redirect_to collection_path(@collection)
    end

private
    def item_params
        params.require(:item).permit(:title, :note, :hiddenText, :swappable, {images: []})
    end
end
