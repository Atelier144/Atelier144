module ApplicationHelper
    def record_get_rank(rank)
        case rank
        when 1
            return "record gold"
        when 2
            return "record silver"
        when 3
            return "record bronze"
        else
            return "record regular"
        end
    end
end
