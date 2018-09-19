module CollectionsHelper
    def itemInSwap?(item)
        if item.swappable
            if (session[:request]) && (session[:request][item.collection_id.to_s]) && (session[:request][item.collection_id.to_s].include? item.id.to_s)
                return true
            end
        end

        false
    end
end
