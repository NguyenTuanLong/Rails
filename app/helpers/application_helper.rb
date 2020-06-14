module ApplicationHelper
    def hide_cart_if(condition, attributes = {}, &block) 
        if condition
            attributes["style"] = "display:none"
        end
        content_tag("div", attributes, &block) 
    end

    def sortable(column, title = nil)
        title ||= column.titleize
        direction = column = sort_column && sort_direction == "asc" ? "desc" : "asc"
        link_to title, params.merge(:sort => column, :direction => direction).permit(:title, :price, :cost, :quantity, :sort, :direction)
    end
end
