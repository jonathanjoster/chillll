module MoviesHelper
    def sort_order(column, title)
        direction = (column == sort_column && sort_direction == 'desc') ? 'asc' : 'desc'
        link_to title, { sort: column, direction: direction }    
    end
end
