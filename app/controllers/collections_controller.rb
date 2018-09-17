class CollectionsController < ApplicationController
    load_and_authorize_resource

    def index
        authorize! :index, Collection

        @collections = Collection.all.page params[:page]
    end

    def show
        @collection = Collection.find(params[:id])
        @items = @collection.items.all.order(id: :desc).page params[:page]
    end

    def new
        authorize! :new, Collection
        @collection = Collection.new
    end

    def edit
        authorize! :manage, Collection, user_id: current_user.id
        @collection = Collection.find(params[:id])
    end

    def create
        authorize! :manage, Collection, user_id: current_user.id
        @collection = Collection.new(collection_params.merge(user_id: current_user.id))

        if @collection.save
            redirect_to @collection
        else
            render 'new'
        end
    end

    def update
        @collection = Collection.find(params[:id])
        authorize! :manage, @collection, user_id: current_user.id

        if @collection.update(collection_params)
            redirect_to @collection
        else
            render 'edit'
        end
    end

    def destroy
        authorize! :manage, Collection, user_id: current_user.id
        @collection = Collection.find(params[:id])

        @collection.destroy

        redirect_to collections_path
    end

private
    def collection_params
        params.require(:collection).permit(:title, :product, :countImages)
    end
end
