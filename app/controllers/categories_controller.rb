class CategoriesController < ApplicationController
    def index
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @categories = Category.where(:collection_id => params[:collection_id]).order(:title);
    end

    def new
        @category = Category.new
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id
    end

    def edit
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @category = @collection.categories.find(params[:id])
    end

    def create
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @category = Category.new(category_params.merge(collection_id: @collection.id))

        if @category.save
            redirect_to collection_categories_path(@collection)
        else
            render 'new'
        end
    end

    def update
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @category = @collection.categories.find(params[:id])

        if @category.update(category_params)
            redirect_to collection_categories_path(@collection)
        else
            render 'edit'
        end
    end

    def destroy
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @category = @collection.categories.find(params[:id])
        @category.destroy
        redirect_to collection_categories_path(@collection)
    end

private
    def category_params
        params.require(:category).permit(:title)
    end
end
