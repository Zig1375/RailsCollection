class RequestsController < ApplicationController
    def index
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @requests = @collection.requests.all.page params[:page]
    end

    def show
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @request = @collection.requests.find(params[:id])
    end
end
