module UsersHelper
    def get_class_publishment_list(f, u)
        return "js-div-checkbox div-checkbox #{is_checked_published_list(f,u) ? "checked" : ""}"
    end

    def get_content_publishment_list(f, u)
        return is_checked_published_list(f,u) ? "公開" : "非公開"
    end

    def get_checked_publishment_list(f, u)
        return is_checked_published_list(f,u) ? "checked" : ""
    end

    private

    def is_checked_published_list(f, u)
        if f.nil?
            if u.nil?
                return true
            elsif u == true
                return true
            else
                return false
            end
        elsif f == true
            return true
        else
            return false
        end
    end
end
