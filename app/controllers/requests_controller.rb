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

        @notRejectedCntItems = 0
        @request.items_requests.each do |req|
            if (req.state != 'rejected')
                @notRejectedCntItems += 1
            end
        end
    end

    def update
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @request = @collection.requests.find(params[:id])

        if @request.update(request_params)
            redirect_to [@collection, @request]
        else
            render 'show'
        end
    end

    def state
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @request = @collection.requests.find(params[:request_id])

        if params[:state] == 'Revert'
            if (@request.state == 'Rejected')
                updateRequestStatus @request
            end
        else
            state = Request.states.key(params[:state].to_i)

            case state
                when 'Sent'
                    if (@request.state == 'Ready')
                        @request.state = 'Sent';
                    end

                when 'Finished'
                    if (@request.state == 'Sent')
                        @request.state = 'Finished';
                    end

                when 'Rejected'
                    if (!["Sent", "Finished", "Rejected"].include?(@request.state))
                        @request.state = 'Rejected';
                    end
            end


            @request.save
        end

        result = {
            request_state: @request.state
        }

        render json: result
    end

    def item
        @collection = Collection.find(params[:collection_id])
        authorize! :manage, @collection, user_id: current_user.id

        @request = @collection.requests.find(params[:request_id])
        itemReq = @request.items_requests.where(item_id: params[:item_id])[0]

        case itemReq.state
            when 'new_item'
                itemReq.state = :approved

            when 'approved'
                itemReq.state = :rejected

            when 'rejected'
                itemReq.state = :new_item
        end

        itemReq.save

        notRejectedCnt = updateRequestStatus @request


        result = {
            request_state: @request.state,
            item: itemReq,
            itemsCnt: notRejectedCnt
        }

        render json: result
    end

private
    def request_params
        params.require(:request).permit(:name, :email, :message)
    end

    def updateRequestStatus(request)
        newCnt = 0
        notRejectedCnt = 0
        request.items_requests.each do |req|
            if req.state == 'new_item'
                newCnt += 1
            end

            if (req.state != 'rejected')
                notRejectedCnt += 1
            end
        end

        if notRejectedCnt > 0
            case request.state
                when 'New request'
                    request.state = 'In process'

                when 'In process'
                    if newCnt == 0
                        request.state = 'Ready'
                    end

                when 'Ready'
                    if newCnt > 0
                        request.state = 'In process'
                    end

                when 'Rejected'
                    if newCnt > 0
                        request.state = 'In process'
                    else
                        request.state = 'Ready'
                    end
            end
        else
            request.state = 'Rejected'
        end

        request.save

        return notRejectedCnt
    end
end
